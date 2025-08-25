-- Projects owned by a user
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  owner uuid not null references auth.users(id) on delete cascade,
  name text not null,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_projects_owner on public.projects(owner);

drop trigger if exists set_updated_at on public.projects;
create trigger set_updated_at
before update on public.projects
for each row
execute procedure public.set_current_timestamp_updated_at();