-- Daily Briefing — Supabase schema
-- Run this once in the Supabase SQL Editor for a new project.
-- See README.md "Authentication and sync" for the full setup, including
-- the Google OAuth provider and URL configuration steps this doesn't cover.

create table if not exists public.daily_logs (
  user_id uuid references auth.users(id) on delete cascade not null,
  log_date date not null,
  tasks jsonb not null default '{}'::jsonb,
  cardio jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, log_date)
);

alter table public.daily_logs enable row level security;

create policy "select own logs" on public.daily_logs
  for select using (auth.uid() = user_id);

create policy "insert own logs" on public.daily_logs
  for insert with check (auth.uid() = user_id);

create policy "update own logs" on public.daily_logs
  for update using (auth.uid() = user_id);
