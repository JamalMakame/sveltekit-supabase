-- Tasks belonging to a project
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  assignee uuid references auth.users(id) on delete set null,
  title text not null,
  description text,
  completed boolean not null default false,
  due_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_tasks_project on public.tasks(project_id);
create index if not exists idx_tasks_assignee on public.tasks(assignee);

drop trigger if exists set_updated_at on public.tasks;
create trigger set_updated_at
before update on public.tasks
for each row
execute procedure public.set_current_timestamp_updated_at();