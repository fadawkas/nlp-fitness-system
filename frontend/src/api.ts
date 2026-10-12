export type Level = "Beginner" | "Intermediate" | "Advanced";

export type Exercise = {
  exercise_name: string;
  target: string;
  prescription: string;
  instructions: string;
};

export type Message = {
  id: number;
  sender: "user" | "bot";
  content: string;
  exercises: Exercise[];
  createdAt: string;
};

type Conversation = { id: string; level: Level; messages: Message[] };

async function request<T>(path: string, options?: RequestInit): Promise<T> {
  const response = await fetch(path, { ...options, headers: { "Content-Type": "application/json", ...options?.headers } });
  if (!response.ok) {
    const body = await response.json().catch(() => ({ error: "Terjadi kesalahan." })) as { error?: string };
    throw new Error(body.error ?? "Terjadi kesalahan.");
  }
  return response.status === 204 ? (undefined as T) : response.json() as Promise<T>;
}

export const api = {
  createConversation: (level: Level) => request<{ id: string; level: Level }>("/api/conversations", { method: "POST", body: JSON.stringify({ level }) }),
  getConversation: (id: string) => request<Conversation>(`/api/conversations/${id}`),
  updateLevel: (id: string, level: Level) => request<{ id: string; level: Level }>(`/api/conversations/${id}`, { method: "PATCH", body: JSON.stringify({ level }) }),
  sendMessage: (id: string, content: string) => request<{ message: Message }>(`/api/conversations/${id}/messages`, { method: "POST", body: JSON.stringify({ content }) }),
  clearMessages: (id: string) => request<void>(`/api/conversations/${id}/messages`, { method: "DELETE" }),
};
