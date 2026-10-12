# RagaBot

RagaBot is an Indonesian fitness chatbot. It classifies messages with a Neural Network TensorFlow model and returns workouts from the original exercise dataset according to the selected fitness level.


## Start development

```bash
docker compose up --build
```

Open `http://localhost:5173`. The API is available at `http://localhost:5000/api/health`.

The frontend has hot reload through Vite, and the Flask backend reloads when backend source files change.

## Stop and reset

Stop services:

```bash
docker compose down
```

Remove all application data, including SQLite history:

```bash
docker compose down -v
```

## Validation commands

Run these commands through Docker Compose:

```bash
docker compose run --rm frontend npm run lint
docker compose run --rm frontend npm run build
docker compose run --rm backend python -c "import app; app.initialize_database(); print('Backend siap')"
```

## Architecture

- `backend/`: Flask API, TensorFlow/NLTK inference, and SQLite persistence.
- `frontend/`: React + TypeScript + Vite chat interface.
- `compose.yaml`: local development services and persistent Docker volumes.
- `Raga-Bot.ipynb`: original model-training notebook retained as project documentation.

## Supported requests

RagaBot supports Indonesian requests for latihan lengan dan dada, perut, kaki, seluruh tubuh, and kardio. Select Pemula, Menengah, or Lanjutan before chatting. A conversation can request a level change with phrases such as `Ganti level saya`.
