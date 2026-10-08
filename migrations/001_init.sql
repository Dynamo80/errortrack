CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE projects (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    public_key TEXT NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE events (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id uuid NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    occured_at timestamptz NOT NULL,
    received_at timestamptz NOT NULL DEFAULT now(),
    type TEXT NOT NULL,
    message TEXT NOT NULL,
    stack text,
    environment text,
    release text,
    context jsonb TEXT NOT NULL DEFAULT '{}' 
)

CREATE INDEX events_project_time_idx ON events (project_id, occured_at DESC);