-- Enable required extension once
create extension if not exists pgcrypto;

-- Helper to keep updated_at fresh
create or replace function public.set_current_timestamp_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- Profiles (linked 1:1 with auth.users)
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  full_name text,
  avatar_url text,
  website text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

drop trigger if exists set_updated_at on public.profiles;
create trigger set_updated_at
before update on public.profiles
for each row
execute procedure public.set_current_timestamp_updated_at();