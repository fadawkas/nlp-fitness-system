import json
import os
import pickle
import random
import re
import sqlite3
import uuid
import csv
from contextlib import closing
from datetime import datetime, timezone
from pathlib import Path

import nltk
import numpy as np
import tensorflow as tf
from flask import Flask, jsonify, request

DATABASE_PATH = os.environ.get("DATABASE_PATH", "/data/ragabot.db")
MODEL_DIR = Path("/model")
VALID_LEVELS = {"Beginner", "Intermediate", "Advanced"}
WORKOUT_TAGS = {"chest_arms", "abs", "legs", "full_body", "cardio"}
FALLBACK_RESPONSES = [
    "Maaf, saya belum memahami permintaan itu. Saya dapat membantu latihan lengan dan dada, perut, kaki, seluruh tubuh, atau kardio.",
    "Mohon jelaskan kembali. Kamu bisa meminta rekomendasi latihan perut, kaki, kardio, lengan dan dada, atau seluruh tubuh.",
]

app = Flask(__name__)


def get_connection():
    connection = sqlite3.connect(DATABASE_PATH)
    connection.row_factory = sqlite3.Row
    connection.execute("PRAGMA foreign_keys = ON")
    return connection


def now():
    return datetime.now(timezone.utc).isoformat()


def initialize_database():
    Path(DATABASE_PATH).parent.mkdir(parents=True, exist_ok=True)
    with closing(get_connection()) as connection:
        connection.executescript(
            """
            CREATE TABLE IF NOT EXISTS exercises (
                id INTEGER PRIMARY KEY,
                category TEXT NOT NULL,
                exercise_name TEXT NOT NULL,
                target TEXT NOT NULL,
                prescription TEXT NOT NULL,
                instructions TEXT NOT NULL,
                level TEXT NOT NULL CHECK(level IN ('Beginner', 'Intermediate', 'Advanced'))
            );
            CREATE TABLE IF NOT EXISTS conversations (
                id TEXT PRIMARY KEY,
                level TEXT NOT NULL CHECK(level IN ('Beginner', 'Intermediate', 'Advanced')),
                pending_action TEXT,
                created_at TEXT NOT NULL,
                updated_at TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS messages (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                conversation_id TEXT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
                sender TEXT NOT NULL CHECK(sender IN ('user', 'bot')),
                content TEXT NOT NULL,
                exercises_json TEXT,
                created_at TEXT NOT NULL
            );
            CREATE INDEX IF NOT EXISTS messages_conversation_id ON messages(conversation_id, id);
            """
        )
        count = connection.execute("SELECT COUNT(*) FROM exercises").fetchone()[0]
        if count == 0:
            seed_exercises(connection)
        connection.commit()


def seed_exercises(connection):
    source = Path("/seed/workouts_db.sql").read_text(encoding="utf-8")
    statements = re.findall(r"INSERT INTO `([^`]+)`.*?VALUES\s*(.*?);", source, re.DOTALL)
    for category, values in statements:
        for row in sql_rows(values):
            fields = next(csv.reader([row], quotechar="'", skipinitialspace=True))
            _, exercise_name, target, prescription, instructions, level = fields
            connection.execute(
                """INSERT INTO exercises (category, exercise_name, target, prescription, instructions, level)
                VALUES (?, ?, ?, ?, ?, ?)""",
                (category, exercise_name, target, prescription, instructions, level),
            )


def sql_rows(values):
    row = []
    depth = 0
    quoted = False
    for character in values:
        if character == "'":
            quoted = not quoted
        if not quoted and character == "(":
            depth += 1
            if depth == 1:
                row = []
                continue
        if not quoted and character == ")":
            depth -= 1
            if depth == 0:
                yield "".join(row)
                continue
        if depth:
            row.append(character)


def load_model_artifacts():
    model = tf.keras.models.load_model(MODEL_DIR / "chatbot_model.h5", compile=False)
    with (MODEL_DIR / "words.pkl").open("rb") as file:
        words = pickle.load(file)
    with (MODEL_DIR / "classes.pkl").open("rb") as file:
        classes = pickle.load(file)
    with (MODEL_DIR / "lemmatizer.pkl").open("rb") as file:
        lemmatizer = pickle.load(file)
    with (MODEL_DIR / "intents.json").open(encoding="utf-8") as file:
        intents = {intent["tag"]: intent for intent in json.load(file)["intents"]}
    if model.input_shape[-1] != len(words) or model.output_shape[-1] != len(classes):
        raise RuntimeError("Artefak model chatbot tidak cocok dengan kosakata atau kelasnya.")
    return model, words, classes, lemmatizer, intents


MODEL, WORDS, CLASSES, LEMMATIZER, INTENTS = load_model_artifacts()


def classify(message):
    tokens = [LEMMATIZER.lemmatize(token.lower()) for token in nltk.word_tokenize(message)]
    vocabulary = set(tokens)
    bag = np.array([1 if word in vocabulary else 0 for word in WORDS])
    probabilities = MODEL.predict(np.array([bag]), verbose=0)[0]
    index = int(np.argmax(probabilities))
    confidence = float(probabilities[index])
    return (CLASSES[index], confidence) if confidence >= 0.5 else ("noanswer", confidence)


def serialize_message(row):
    return {
        "id": row["id"],
        "sender": row["sender"],
        "content": row["content"],
        "exercises": json.loads(row["exercises_json"]) if row["exercises_json"] else [],
        "createdAt": row["created_at"],
    }


def get_conversation(connection, conversation_id):
    return connection.execute("SELECT * FROM conversations WHERE id = ?", (conversation_id,)).fetchone()


def list_exercises(connection, category, level):
    rows = connection.execute(
        """SELECT exercise_name, target, prescription, instructions FROM exercises
        WHERE category = ? AND level = ? ORDER BY id""",
        (category, level),
    ).fetchall()
    return [dict(row) for row in rows]


def response_for_message(connection, conversation, message):
    tag, _ = classify(message)
    if conversation["pending_action"] == "change_level" and tag == "noanswer":
        return "Pilih level melalui menu di atas: Pemula, Menengah, atau Lanjutan.", []
    if tag in WORKOUT_TAGS:
        exercises = list_exercises(connection, tag, conversation["level"])
        label = {
            "chest_arms": "lengan dan dada", "abs": "perut", "legs": "kaki",
            "full_body": "seluruh tubuh", "cardio": "kardio",
        }[tag]
        return f"Berikut latihan {label} untuk level {level_label(conversation['level'])}.", exercises
    if tag == "level":
        connection.execute("UPDATE conversations SET pending_action = ?, updated_at = ? WHERE id = ?", ("change_level", now(), conversation["id"]))
        return "Silakan pilih level baru melalui menu di atas: Pemula, Menengah, atau Lanjutan.", []
    if tag == "noanswer":
        return random.choice(FALLBACK_RESPONSES), []
    intent = INTENTS[tag]
    return random.choice(intent["responses"]).strip(), []


def level_label(level):
    return {"Beginner": "Pemula", "Intermediate": "Menengah", "Advanced": "Lanjutan"}[level]


def require_json():
    payload = request.get_json(silent=True)
    if not isinstance(payload, dict):
        return None, (jsonify({"error": "Permintaan harus berupa JSON."}), 400)
    return payload, None


@app.get("/api/health")
def health():
    return jsonify({"status": "ok", "model": "loaded", "classes": len(CLASSES)})


@app.post("/api/conversations")
def create_conversation():
    payload, error = require_json()
    if error:
        return error
    level = payload.get("level")
    if level not in VALID_LEVELS:
        return jsonify({"error": "Level tidak valid."}), 400
    conversation_id = str(uuid.uuid4())
    timestamp = now()
    with closing(get_connection()) as connection:
        connection.execute("INSERT INTO conversations VALUES (?, ?, NULL, ?, ?)", (conversation_id, level, timestamp, timestamp))
        connection.commit()
    return jsonify({"id": conversation_id, "level": level}), 201


@app.get("/api/conversations/<conversation_id>")
def get_conversation_route(conversation_id):
    with closing(get_connection()) as connection:
        conversation = get_conversation(connection, conversation_id)
        if not conversation:
            return jsonify({"error": "Percakapan tidak ditemukan."}), 404
        rows = connection.execute("SELECT * FROM messages WHERE conversation_id = ? ORDER BY id", (conversation_id,)).fetchall()
    return jsonify({"id": conversation_id, "level": conversation["level"], "messages": [serialize_message(row) for row in rows]})


@app.patch("/api/conversations/<conversation_id>")
def update_conversation(conversation_id):
    payload, error = require_json()
    if error:
        return error
    level = payload.get("level")
    if level not in VALID_LEVELS:
        return jsonify({"error": "Level tidak valid."}), 400
    with closing(get_connection()) as connection:
        if not get_conversation(connection, conversation_id):
            return jsonify({"error": "Percakapan tidak ditemukan."}), 404
        connection.execute("UPDATE conversations SET level = ?, pending_action = NULL, updated_at = ? WHERE id = ?", (level, now(), conversation_id))
        connection.commit()
    return jsonify({"id": conversation_id, "level": level})


@app.post("/api/conversations/<conversation_id>/messages")
def create_message(conversation_id):
    payload, error = require_json()
    if error:
        return error
    content = payload.get("content")
    if not isinstance(content, str) or not content.strip() or len(content) > 1000:
        return jsonify({"error": "Pesan harus berisi 1 sampai 1000 karakter."}), 400
    content = content.strip()
    with closing(get_connection()) as connection:
        conversation = get_conversation(connection, conversation_id)
        if not conversation:
            return jsonify({"error": "Percakapan tidak ditemukan."}), 404
        connection.execute("INSERT INTO messages (conversation_id, sender, content, created_at) VALUES (?, 'user', ?, ?)", (conversation_id, content, now()))
        response, exercises = response_for_message(connection, conversation, content)
        cursor = connection.execute("INSERT INTO messages (conversation_id, sender, content, exercises_json, created_at) VALUES (?, 'bot', ?, ?, ?)", (conversation_id, response, json.dumps(exercises), now()))
        connection.execute("UPDATE conversations SET updated_at = ? WHERE id = ?", (now(), conversation_id))
        connection.commit()
        bot_message = connection.execute("SELECT * FROM messages WHERE id = ?", (cursor.lastrowid,)).fetchone()
    return jsonify({"message": serialize_message(bot_message)})


@app.delete("/api/conversations/<conversation_id>/messages")
def clear_messages(conversation_id):
    with closing(get_connection()) as connection:
        if not get_conversation(connection, conversation_id):
            return jsonify({"error": "Percakapan tidak ditemukan."}), 404
        connection.execute("DELETE FROM messages WHERE conversation_id = ?", (conversation_id,))
        connection.execute("UPDATE conversations SET pending_action = NULL, updated_at = ? WHERE id = ?", (now(), conversation_id))
        connection.commit()
    return "", 204


if __name__ == "__main__":
    initialize_database()
    app.run(host="0.0.0.0", port=5000, debug=os.environ.get("FLASK_DEBUG") == "1")
