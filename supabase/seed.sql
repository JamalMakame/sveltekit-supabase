-- Seed users, profiles, projects, tasks for local dev
create extension if not exists pgcrypto;

do $$
declare
  alice_id uuid := '11111111-1111-1111-1111-111111111111';
  bob_id   uuid := '22222222-2222-2222-2222-222222222222';
  p1_id    uuid := '33333333-3333-3333-3333-333333333333';
  p2_id    uuid := '44444444-4444-4444-4444-444444444444';
begin
  -- Create or ensure Alice
  if not exists (select 1 from auth.users where id = alice_id or email = 'alice@example.com') then
    insert into auth.users (id, email, encrypted_password, email_confirmed_at)
    values (alice_id, 'alice@example.com', crypt('password123', gen_salt('bf')), now());
  end if;

  -- Create or ensure Bob
  if not exists (select 1 from auth.users where id = bob_id or email = 'bob@example.com') then
    insert into auth.users (id, email, encrypted_password, email_confirmed_at)
    values (bob_id, 'bob@example.com', crypt('hunter2', gen_salt('bf')), now());
  end if;

  -- Upsert profiles
  insert into public.profiles (id, username, full_name, avatar_url, website)
  values
    (alice_id, 'alice', 'Alice Doe', null, 'https://example.com/alice'),
    (bob_id,   'bob',   'Bob Smith', null, 'https://example.com/bob')
  on conflict (id) do update
    set username = excluded.username,
        full_name = excluded.full_name,
        avatar_url = excluded.avatar_url,
        website = excluded.website,
        updated_at = now();

  -- Projects owned by Alice
  insert into public.projects (id, owner, name, description)
  values
    (p1_id, alice_id, 'Marketing Website', 'Build the new company site'),
    (p2_id, alice_id, 'Mobile App', 'Ship MVP for iOS/Android')
  on conflict (id) do nothing;

  -- Tasks across projects
  insert into public.tasks (project_id, assignee, title, description, completed, due_date)
  values
    (p1_id, alice_id, 'Draft copy', 'Homepage + features', false, current_date + 7),
    (p1_id, bob_id,   'Implement layout', 'Hero + pricing', false, current_date + 10),
    (p1_id, null,     'SEO checklist', 'Meta, sitemap, robots', false, null),
    (p2_id, alice_id, 'Auth flow', 'Email OTP + session', false, current_date + 5),
    (p2_id, bob_id,   'Task list UI', 'List, filters, empty states', false, current_date + 14);
end $$;