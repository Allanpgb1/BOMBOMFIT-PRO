-- Bombom Fit: schema inicial
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text,
  age integer check (age is null or age between 10 and 120),
  weight_kg numeric(6,2) check (weight_kg is null or weight_kg between 20 and 500),
  height_cm numeric(6,2) check (height_cm is null or height_cm between 80 and 250),
  activity_minutes integer not null default 0 check (activity_minutes >= 0),
  water_goal_ml numeric(8,0) not null default 2000,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.water_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  amount_ml integer not null check (amount_ml between 50 and 3000),
  consumed_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.workouts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  duration_minutes integer not null default 30,
  calories integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.workout_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  workout_id uuid references public.workouts(id) on delete set null,
  duration_minutes integer not null default 0,
  calories integer not null default 0,
  completed_at timestamptz not null default now()
);

create table if not exists public.nutrition_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  log_date date not null default current_date,
  meal text not null,
  calories integer not null default 0,
  protein_g numeric(8,2) not null default 0,
  carbs_g numeric(8,2) not null default 0,
  fat_g numeric(8,2) not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.daily_activity (
  user_id uuid not null references auth.users(id) on delete cascade,
  activity_date date not null,
  steps integer not null default 0 check (steps >= 0),
  primary key (user_id, activity_date)
);

create table if not exists public.progress_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  weight_kg numeric(6,2),
  body_fat_pct numeric(5,2),
  waist_cm numeric(6,2),
  note text,
  measured_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.water_entries enable row level security;
alter table public.workouts enable row level security;
alter table public.workout_logs enable row level security;
alter table public.nutrition_logs enable row level security;
alter table public.daily_activity enable row level security;
alter table public.progress_logs enable row level security;

create policy "profiles_select_own" on public.profiles for select using (auth.uid() = id);
create policy "profiles_insert_own" on public.profiles for insert with check (auth.uid() = id);
create policy "profiles_update_own" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);

create policy "water_select_own" on public.water_entries for select using (auth.uid() = user_id);
create policy "water_insert_own" on public.water_entries for insert with check (auth.uid() = user_id);
create policy "water_delete_own" on public.water_entries for delete using (auth.uid() = user_id);

create policy "workouts_public_read" on public.workouts for select using (is_active = true);
create policy "workout_logs_own" on public.workout_logs for select using (auth.uid() = user_id);
create policy "workout_logs_insert_own" on public.workout_logs for insert with check (auth.uid() = user_id);

create policy "nutrition_own" on public.nutrition_logs for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "activity_own" on public.daily_activity for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "progress_own" on public.progress_logs for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

insert into public.workouts (title, description, duration_minutes, calories)
select * from (values
  ('Caminhada ativa', 'Cardio leve para começar o dia.', 30, 150),
  ('Treino corpo inteiro', 'Circuito básico de força.', 35, 240),
  ('HIIT iniciante', 'Intervalos curtos de alta intensidade.', 20, 220)
) as v(title, description, duration_minutes, calories)
where not exists (select 1 from public.workouts);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id) values (new.id)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
