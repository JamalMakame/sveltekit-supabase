-- Grant basic privileges to authenticated users
grant usage on schema public to authenticated;
grant select, insert, update, delete on public.profiles to authenticated;
grant select, insert, update, delete on public.projects to authenticated;
grant select, insert, update, delete on public.tasks to authenticated;

-- Enable RLS
alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.tasks enable row level security;

-- Profiles policies
drop policy if exists "profiles_select_all_auth" on public.profiles;
create policy "profiles_select_all_auth"
on public.profiles
for select
to authenticated
using (true);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own"
on public.profiles
for insert
to authenticated
with check (auth.uid() = id);

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own"
on public.profiles
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

-- Projects policies (owner-only)
drop policy if exists "projects_select_owner" on public.projects;
create policy "projects_select_owner"
on public.projects
for select
to authenticated
using (owner = auth.uid());

drop policy if exists "projects_insert_owner" on public.projects;
create policy "projects_insert_owner"
on public.projects
for insert
to authenticated
with check (owner = auth.uid());

drop policy if exists "projects_update_owner" on public.projects;
create policy "projects_update_owner"
on public.projects
for update
to authenticated
using (owner = auth.uid())
with check (owner = auth.uid());

drop policy if exists "projects_delete_owner" on public.projects;
create policy "projects_delete_owner"
on public.projects
for delete
to authenticated
using (owner = auth.uid());

-- Tasks policies (project owner or assignee)
drop policy if exists "tasks_select_owner_or_assignee" on public.tasks;
create policy "tasks_select_owner_or_assignee"
on public.tasks
for select
to authenticated
using (
  assignee = auth.uid()
  or exists (
    select 1 from public.projects p
    where p.id = tasks.project_id and p.owner = auth.uid()
  )
);

drop policy if exists "tasks_insert_owner_or_assignee" on public.tasks;
create policy "tasks_insert_owner_or_assignee"
on public.tasks
for insert
to authenticated
with check (
  assignee = auth.uid()
  or exists (
    select 1 from public.projects p
    where p.id = tasks.project_id and p.owner = auth.uid()
  )
);

drop policy if exists "tasks_update_owner_or_assignee" on public.tasks;
create policy "tasks_update_owner_or_assignee"
on public.tasks
for update
to authenticated
using (
  assignee = auth.uid()
  or exists (
    select 1 from public.projects p
    where p.id = tasks.project_id and p.owner = auth.uid()
  )
)
with check (
  assignee = auth.uid()
  or exists (
    select 1 from public.projects p
    where p.id = tasks.project_id and p.owner = auth.uid()
  )
);

drop policy if exists "tasks_delete_owner_or_assignee" on public.tasks;
create policy "tasks_delete_owner_or_assignee"
on public.tasks
for delete
to authenticated
using (
  assignee = auth.uid()
  or exists (
    select 1 from public.projects p
    where p.id = tasks.project_id and p.owner = auth.uid()
  )
);