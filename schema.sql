-- Execute this SQL in the Cloudflare D1 console or with Wrangler.
CREATE TABLE IF NOT EXISTS reports (
  id TEXT PRIMARY KEY,
  code TEXT NOT NULL UNIQUE,
  category TEXT NOT NULL,
  description TEXT NOT NULL,
  neighborhood TEXT,
  anonymous INTEGER NOT NULL DEFAULT 1,
  status TEXT NOT NULL DEFAULT 'Recebido',
  published INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS reports_code_idx ON reports(code);
CREATE INDEX IF NOT EXISTS reports_public_idx ON reports(published,status);
