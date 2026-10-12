import { FormEvent, KeyboardEvent, useEffect, useRef, useState } from "react";
import { api, Exercise, Level, Message } from "./api";
import logo from "./assets/RagaBot_Logo.png";
import botAvatar from "./assets/RagaChat_Logo.png";
import userAvatar from "./assets/YourChat_Logo.png";

const levels: Array<{ value: Level; label: string; description: string }> = [
  { value: "Beginner", label: "Pemula", description: "Baru memulai atau kembali aktif setelah jeda." },
  { value: "Intermediate", label: "Menengah", description: "Sudah rutin dan siap meningkatkan intensitas." },
  { value: "Advanced", label: "Lanjutan", description: "Berpengalaman dengan latihan yang menantang." },
];

const prompts = [
  { label: "Lengan & dada", message: "Berikan olahraga lengan dan dada" },
  { label: "Perut", message: "Berikan olahraga perut" },
  { label: "Kaki", message: "Berikan olahraga kaki" },
  { label: "Seluruh tubuh", message: "Berikan olahraga seluruh tubuh" },
  { label: "Kardio", message: "Berikan olahraga cardio" },
];
const storageKey = "ragabot-conversation-id";

function levelLabel(level: Level) {
  return levels.find((item) => item.value === level)?.label ?? level;
}

export default function App() {
  const [conversationId, setConversationId] = useState<string | null>(() => localStorage.getItem(storageKey));
  const [level, setLevel] = useState<Level | null>(null);
  const [messages, setMessages] = useState<Message[]>([]);
  const [draft, setDraft] = useState("");
  const [isLoading, setIsLoading] = useState(Boolean(conversationId));
  const [isSending, setIsSending] = useState(false);
  const [isLevelMenuOpen, setIsLevelMenuOpen] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const transcriptRef = useRef<HTMLDivElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    if (!conversationId) return;
    api.getConversation(conversationId)
      .then((conversation) => {
        setLevel(conversation.level);
        setMessages(conversation.messages);
      })
      .catch(() => {
        localStorage.removeItem(storageKey);
        setConversationId(null);
      })
      .finally(() => setIsLoading(false));
  }, [conversationId]);

  useEffect(() => {
    transcriptRef.current?.scrollTo({ top: transcriptRef.current.scrollHeight, behavior: "smooth" });
  }, [messages, isSending]);

  function resizeTextarea() {
    const textarea = textareaRef.current;
    if (!textarea) return;
    textarea.style.height = "auto";
    textarea.style.height = `${Math.min(textarea.scrollHeight, 136)}px`;
  }

  async function chooseLevel(nextLevel: Level) {
    setIsLevelMenuOpen(false);
    setError(null);
    try {
      if (!conversationId) {
        const conversation = await api.createConversation(nextLevel);
        localStorage.setItem(storageKey, conversation.id);
        setConversationId(conversation.id);
        setLevel(conversation.level);
        setMessages([{ id: 0, sender: "bot", content: `Halo, saya RagaBot. Level ${levelLabel(nextLevel)} sudah dipilih. Bagian tubuh mana yang ingin kamu latih hari ini?`, exercises: [], createdAt: "" }]);
      } else {
        await api.updateLevel(conversationId, nextLevel);
        setLevel(nextLevel);
        setMessages((current) => [...current, { id: Date.now(), sender: "bot", content: `Level latihan diubah menjadi ${levelLabel(nextLevel)}.`, exercises: [], createdAt: "" }]);
      }
    } catch (caught) {
      setError(caught instanceof Error ? caught.message : "Level tidak dapat diubah. Coba lagi.");
    }
  }

  async function sendMessage(content = draft) {
    if (!conversationId || !content.trim() || isSending) return;
    setIsSending(true);
    setError(null);
    const text = content.trim();
    setDraft("");
    const temporary: Message = { id: Date.now(), sender: "user", content: text, exercises: [], createdAt: "" };
    setMessages((current) => [...current, temporary]);
    try {
      const response = await api.sendMessage(conversationId, text);
      setMessages((current) => [...current.filter((message) => message.id !== temporary.id), temporary, response.message]);
    } catch (caught) {
      setMessages((current) => current.filter((message) => message.id !== temporary.id));
      setDraft(text);
      setError(caught instanceof Error ? caught.message : "Pesan tidak dapat dikirim. Coba lagi.");
    } finally {
      setIsSending(false);
    }
  }

  function submit(event: FormEvent) {
    event.preventDefault();
    void sendMessage();
  }

  function keyDown(event: KeyboardEvent<HTMLTextAreaElement>) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      void sendMessage();
    }
  }

  async function reset() {
    if (!conversationId) return;
    setError(null);
    try {
      await api.clearMessages(conversationId);
      setMessages([]);
    } catch (caught) {
      setError(caught instanceof Error ? caught.message : "Riwayat tidak dapat dihapus. Coba lagi.");
    }
  }

  return (
    <main className="app-shell">
      {isLoading ? <section className="loading-screen"><img src={logo} alt="RagaBot" /><p>Menyiapkan latihanmu...</p></section> : !level ? (
        <WelcomeScreen error={error} onChooseLevel={chooseLevel} />
      ) : (
        <section className="chat-shell">
          <header className="chat-topbar">
            <div className="topbar-brand"><img src={logo} alt="RagaBot" /><div><strong>RagaBot</strong><span>Teman latihanmu</span></div></div>
            <div className="topbar-actions"><div className="level-control"><button className="level-trigger" type="button" onClick={() => setIsLevelMenuOpen((open) => !open)} disabled={isSending} aria-expanded={isLevelMenuOpen} aria-haspopup="menu"><span className={`level-status ${level.toLowerCase()}`} /><span className="level-trigger-label">Level</span><strong>{levelLabel(level)}</strong><span className="chevron" aria-hidden="true">⌄</span></button>{isLevelMenuOpen && <div className="level-menu" role="menu" aria-label="Pilih level latihan">{levels.map((item) => <button key={item.value} type="button" role="menuitem" className={item.value === level ? "selected" : ""} onClick={() => void chooseLevel(item.value)}><span className={`level-status ${item.value.toLowerCase()}`} /><span>{item.label}</span>{item.value === level && <span aria-hidden="true">✓</span>}</button>)}</div>}</div><button className="clear-button" type="button" onClick={() => void reset()} disabled={isSending}>Hapus riwayat</button></div>
          </header>
          <nav className="workout-bar" aria-label="Pilih jenis latihan"><span>Mulai latihan</span>{prompts.map((prompt) => <button key={prompt.message} type="button" onClick={() => void sendMessage(prompt.message)} disabled={isSending}>{prompt.label}</button>)}</nav>
          <section className="conversation-panel">
            <header className="conversation-header"><div><p>ASISTEN LATIHAN PRIBADI</p><h1>Latihan hari ini</h1></div></header>
            <div className="transcript" ref={transcriptRef} aria-live="polite">{messages.length === 0 && <EmptyChat />}{messages.map((message) => <ChatMessage key={message.id} message={message} />)}{isSending && <div className="message bot"><img className="avatar" src={botAvatar} alt="" /><div className="bubble typing"><span /><span /><span /></div></div>}</div>
            <form className="composer" onSubmit={submit}><label className="sr-only" htmlFor="message">Pesan untuk RagaBot</label><textarea ref={textareaRef} id="message" value={draft} onChange={(event) => { setDraft(event.target.value); resizeTextarea(); }} onKeyDown={keyDown} placeholder="Tulis tujuan latihanmu..." rows={1} maxLength={1000} /><button type="submit" disabled={!draft.trim() || isSending} aria-label="Kirim pesan"><SendIcon /></button></form>
            <p className="composer-hint">Enter untuk kirim · Shift + Enter untuk baris baru</p>
            {error && <p className="error" role="alert">{error}</p>}
          </section>
        </section>
      )}
    </main>
  );
}

function WelcomeScreen({ error, onChooseLevel }: { error: string | null; onChooseLevel: (level: Level) => Promise<void> }) {
  return <section className="welcome-screen"><div className="welcome-copy"><img src={logo} alt="Logo RagaBot" /><p>ASISTEN LATIHAN PRIBADI</p><h1>Mulai dari tubuhmu,<br />bukan tebakan.</h1><span>RagaBot menyiapkan latihan berdasarkan level kebugaranmu.</span></div><div className="level-picker"><div><p>LANGKAH PERTAMA</p><h2>Pilih levelmu</h2><span>Ini membantu RagaBot memilih latihan yang tepat.</span></div><div className="level-options">{levels.map((item) => <button key={item.value} type="button" className={`level-card ${item.value.toLowerCase()}`} onClick={() => void onChooseLevel(item.value)}><strong>{item.label}</strong><span>{item.description}</span><i>Mulai →</i></button>)}</div>{error && <p className="error" role="alert">{error}</p>}</div></section>;
}

function EmptyChat() {
  return <div className="empty-chat"><img src={botAvatar} alt="" /><h2>Siap menyusun latihanmu?</h2><p>Pilih jenis latihan di atas atau ceritakan tujuan latihanmu.</p></div>;
}

function ChatMessage({ message }: { message: Message }) {
  const isBot = message.sender === "bot";
  return <div className={`message ${message.sender}`}><img className="avatar" src={isBot ? botAvatar : userAvatar} alt={isBot ? "RagaBot" : "Kamu"} /><div className="message-content"><span>{isBot ? "RagaBot" : "Kamu"}</span><div className="bubble"><p>{message.content}</p>{message.exercises.map((exercise) => <ExerciseCard key={`${exercise.exercise_name}-${exercise.prescription}`} exercise={exercise} />)}</div></div></div>;
}

function ExerciseCard({ exercise }: { exercise: Exercise }) {
  return <article className="exercise-card"><div className="exercise-title"><h2>{exercise.exercise_name}</h2><span>Rekomendasi</span></div><dl><div><dt>Target</dt><dd>{exercise.target}</dd></div><div><dt>Set / durasi</dt><dd>{exercise.prescription}</dd></div></dl><p>{exercise.instructions}</p></article>;
}

function SendIcon() {
  return <svg viewBox="0 0 24 24" aria-hidden="true"><path d="m21 3-7.7 18-2.8-7.5L3 10.7 21 3Z" /><path d="m10.5 13.5 4-4" /></svg>;
}
