-- Create users table (extends Supabase auth.users)
create table public.users (
  id uuid references auth.users on delete cascade not null primary key,
  email text unique not null,
  full_name text,
  avatar_url text,
  preferences jsonb default '{}'::jsonb,
  current_streak integer default 0,
  total_points integer default 0,
  monthly_points integer default 0,
  prestige_level text default 'Novice Sloucher',
  last_workout_date timestamp with time zone,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Create workouts table
create table public.workouts (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  duration integer not null, -- in minutes
  difficulty text not null,
  category text not null,
  thumbnail_url text,
  video_url text,
  exercises jsonb not null, -- Array of exercise objects
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Create user_workouts table
create table public.user_workouts (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  workout_id uuid references public.workouts(id) on delete cascade not null,
  completed_at timestamp with time zone default now(),
  duration integer, -- actual duration in minutes
  points_earned integer,
  feedback jsonb, -- User feedback and performance metrics
  created_at timestamp with time zone default now()
);

-- Create reminders table
create table public.reminders (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  title text not null,
  message text not null,
  schedule jsonb not null, -- Contains time blocks and days
  is_active boolean default true,
  custom_messages jsonb, -- Array of custom reminder messages
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Create progress table
create table public.progress (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  date date not null,
  workouts_completed integer default 0,
  points_earned integer default 0,
  streak_count integer default 0,
  goals_achieved jsonb, -- Array of achieved goals
  created_at timestamp with time zone default now()
);

-- Create leaderboard table
create table public.leaderboard (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  weekly_points integer default 0,
  monthly_points integer default 0,
  total_points integer default 0,
  rank integer,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Create achievements table
create table public.achievements (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text not null,
  icon text not null,
  points integer not null,
  requirements jsonb not null, -- Achievement requirements
  created_at timestamp with time zone default now()
);

-- Create user_achievements table
create table public.user_achievements (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  achievement_id uuid references public.achievements(id) on delete cascade not null,
  progress double default 0,
  completed_at timestamp with time zone,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Create RLS policies
alter table public.users enable row level security;
alter table public.workouts enable row level security;
alter table public.user_workouts enable row level security;
alter table public.reminders enable row level security;
alter table public.progress enable row level security;
alter table public.leaderboard enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;

-- Users policies
create policy "Users can view their own data"
  on public.users for select
  using (auth.uid() = id);

create policy "Users can update their own data"
  on public.users for update
  using (auth.uid() = id);

-- Workouts policies
create policy "Anyone can view workouts"
  on public.workouts for select
  to authenticated
  using (true);

-- User workouts policies
create policy "Users can view their own workouts"
  on public.user_workouts for select
  using (auth.uid() = user_id);

create policy "Users can insert their own workouts"
  on public.user_workouts for insert
  with check (auth.uid() = user_id);

-- Reminders policies
create policy "Users can view their own reminders"
  on public.reminders for select
  using (auth.uid() = user_id);

create policy "Users can manage their own reminders"
  on public.reminders for all
  using (auth.uid() = user_id);

-- Progress policies
create policy "Users can view their own progress"
  on public.progress for select
  using (auth.uid() = user_id);

create policy "Users can insert their own progress"
  on public.progress for insert
  with check (auth.uid() = user_id);

-- Leaderboard policies
create policy "Anyone can view leaderboard"
  on public.leaderboard for select
  to authenticated
  using (true);

-- Achievements policies
create policy "Anyone can view achievements"
  on public.achievements for select
  to authenticated
  using (true);

-- User achievements policies
create policy "Users can view their own achievements"
  on public.user_achievements for select
  using (auth.uid() = user_id);

create policy "Users can update their own achievements"
  on public.user_achievements for update
  using (auth.uid() = user_id);

-- Create functions
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id, email, full_name)
  values (new.id, new.email, new.raw_user_meta_data->>'full_name');
  return new;
end;
$$ language plpgsql security definer;

-- Create trigger for new user
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Create function to update leaderboard
create or replace function public.update_leaderboard()
returns trigger as $$
begin
  -- Update user's points
  update public.users
  set total_points = total_points + new.points_earned,
      monthly_points = monthly_points + new.points_earned
  where id = new.user_id;

  -- Update leaderboard
  update public.leaderboard
  set weekly_points = weekly_points + new.points_earned,
      monthly_points = monthly_points + new.points_earned,
      total_points = total_points + new.points_earned,
      updated_at = now()
  where user_id = new.user_id;

  return new;
end;
$$ language plpgsql security definer;

-- Create trigger for workout completion
create trigger on_workout_completed
  after insert on public.user_workouts
  for each row execute procedure public.update_leaderboard(); 