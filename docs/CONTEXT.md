# Fix My Posture - App Design Documentation

## Overview
Fix My Posture is a habit-forming posture correction app designed to help users improve their posture through reminders, exercises, and progress tracking.

## Core Features

### 1. Reminder System
- **Customizable Schedules**
  - Set blocks of time throughout the week for posture correction notifications
  - Adjust frequency based on daily routines (e.g., every 30 minutes during work hours)
  - Configure different frequencies for different times of day
  - Option to disable during sleeping hours

- **Custom Reminder Messages**
  - Personalized phrases like "Roll shoulders back"
  - "Align your spine"
  - "Chin parallel to floor"
  - Address specific posture challenges

- **Quick Fix Feature**
  - Tap notification to view 5-second animation
  - Demonstrates correct adjustment for common posture issues

### 2. Comprehensive Workout Library
- **Exercise Categories**
  - Quick 2-minute "posture breaks"
  - Comprehensive 20-minute daily routines
  - Specialized exercises for:
    - Neck tension
    - Rounded shoulders
    - Anterior pelvic tilt
    - Scoliosis
    - Core strength

- **Exercise Features**
  - Animated demonstrations
  - Timer/rep counter
  - Audio instructions
    - Initial exercise guidance
    - Half-time notification
    - 3-second countdown
  - Progress tracking
  - Intelligent workout recommendations based on:
    - User-reported problem areas
    - Progress in strength and flexibility

### 3. Progress Tracking
- **Overview Section**
  - Progress ring showing completion percentage
  - Current goal status

- **Calendar View**
  - Day tracker for workout completion
  - Color-coded completion status
  - Dimmed colors for partial completion

- **Streak Tracking**
  - Best streaks display
  - Bar visualization of streak length
  - Date range display
  - Dimming effect for shorter streaks

- **Leaderboard Integration**
  - Current position display
  - Monthly points
  - Total points
  - User title/prestige level

### 4. Social Ranking System ("Posture League")
- **Prestige Levels**
  - Progressive title system:
    1. Novice Sloucher
    2. Posture Apprentice
    3. Spine Aligner
    4. Posture Warrior
    5. Alignment Master
    6. Posture Royalty
    7. Spine Sage

- **Leaderboard Categories**
  - Weekly Warriors (resets weekly)
  - All-Time Alignment (lifetime points)

### 5. Settings
- **Account Settings**
  - Profile management
  - Email preferences
  - Password management

- **App Settings**
  - Notification preferences
  - Auto-start workout options
  - Daily goal configuration
  - Theme customization
  - Sound effect controls

- **Privacy Settings**
  - Profile visibility
  - Leaderboard participation
  - Regional preferences

- **Support**
  - FAQ access
  - Contact support
  - Terms & Privacy

## UI/UX Design
The app features a modern, clean interface with:
- Intuitive navigation
- Clear progress visualization
- Engaging animations
- Accessible controls
- Consistent color scheme
- Responsive design elements

## Technical Requirements
- Mobile-first design
- Cross-platform compatibility
- Offline functionality
- Secure user authentication
- Data synchronization
- Push notification support
- Audio playback capabilities
- Animation support

## Tech Stack

### Frontend
- **Framework**: Flutter + Dart
- **Navigation**: Flutter Navigation 2.0 (or Go Router)

### UI Framework
- Material Design 3 (Flutter's built-in Material components)
- Alternative UI libraries:
  - GetX UI
  - Flutter Hooks

### Backend/Database
- **Platform**: Supabase
  - Authentication
  - Real-time database
  - Storage
  - Edge Functions

### AI Processing
- **Model**: Claude
  - Posture analysis
  - Exercise recommendations
  - Progress tracking

### State Management
- **Options**:
  - Provider
  - Riverpod
  - Bloc pattern
  - GetX (for simplified state management)

### Package Management
- Dart's pub package manager
  - Dependency management
  - Version control
  - Package publishing

## Database Schema

### Users Table
```sql
users (
  id: uuid PRIMARY KEY,
  email: text UNIQUE NOT NULL,
  created_at: timestamp with time zone DEFAULT now(),
  updated_at: timestamp with time zone DEFAULT now(),
  full_name: text,
  avatar_url: text,
  preferences: jsonb,
  current_streak: integer DEFAULT 0,
  total_points: integer DEFAULT 0,
  monthly_points: integer DEFAULT 0,
  prestige_level: text DEFAULT 'Novice Sloucher',
  last_workout_date: timestamp with time zone
)
```

### Workouts Table
```sql
workouts (
  id: uuid PRIMARY KEY,
  title: text NOT NULL,
  description: text,
  duration: integer NOT NULL, -- in minutes
  difficulty: text NOT NULL,
  category: text NOT NULL,
  thumbnail_url: text,
  video_url: text,
  created_at: timestamp with time zone DEFAULT now(),
  updated_at: timestamp with time zone DEFAULT now(),
  exercises: jsonb NOT NULL -- Array of exercise objects
)
```

### User_Workouts Table
```sql
user_workouts (
  id: uuid PRIMARY KEY,
  user_id: uuid REFERENCES users(id),
  workout_id: uuid REFERENCES workouts(id),
  completed_at: timestamp with time zone DEFAULT now(),
  duration: integer, -- actual duration in minutes
  points_earned: integer,
  feedback: jsonb -- User feedback and performance metrics
)
```

### Reminders Table
```sql
reminders (
  id: uuid PRIMARY KEY,
  user_id: uuid REFERENCES users(id),
  title: text NOT NULL,
  message: text NOT NULL,
  schedule: jsonb NOT NULL, -- Contains time blocks and days
  is_active: boolean DEFAULT true,
  created_at: timestamp with time zone DEFAULT now(),
  updated_at: timestamp with time zone DEFAULT now(),
  custom_messages: jsonb -- Array of custom reminder messages
)
```

### Progress Table
```sql
progress (
  id: uuid PRIMARY KEY,
  user_id: uuid REFERENCES users(id),
  date: date NOT NULL,
  workouts_completed: integer DEFAULT 0,
  points_earned: integer DEFAULT 0,
  streak_count: integer DEFAULT 0,
  goals_achieved: jsonb, -- Array of achieved goals
  created_at: timestamp with time zone DEFAULT now()
)
```

### Leaderboard Table
```sql
leaderboard (
  id: uuid PRIMARY KEY,
  user_id: uuid REFERENCES users(id),
  weekly_points: integer DEFAULT 0,
  monthly_points: integer DEFAULT 0,
  total_points: integer DEFAULT 0,
  rank: integer,
  updated_at: timestamp with time zone DEFAULT now()
)
```

## Project Structure
```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── theme_constants.dart
│   │   └── api_constants.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   ├── network_info.dart
│   │   └── api_client.dart
│   └── utils/
│       ├── date_formatter.dart
│       └── validators.dart
│
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── workout_local_datasource.dart
│   │   │   └── reminder_local_datasource.dart
│   │   └── remote/
│   │       ├── workout_remote_datasource.dart
│   │       └── user_remote_datasource.dart
│   ├── models/
│   │   ├── workout_model.dart
│   │   ├── user_model.dart
│   │   └── reminder_model.dart
│   └── repositories/
│       ├── workout_repository_impl.dart
│       └── user_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── workout.dart
│   │   ├── user.dart
│   │   └── reminder.dart
│   ├── repositories/
│   │   ├── workout_repository.dart
│   │   └── user_repository.dart
│   └── usecases/
│       ├── get_workouts.dart
│       └── update_user_progress.dart
│
├── presentation/
│   ├── bloc/
│   │   ├── workout/
│   │   │   ├── workout_bloc.dart
│   │   │   ├── workout_event.dart
│   │   │   └── workout_state.dart
│   │   └── user/
│   │       ├── user_bloc.dart
│   │       ├── user_event.dart
│   │       └── user_state.dart
│   ├── pages/
│   │   ├── home/
│   │   ├── workouts/
│   │   ├── progress/
│   │   ├── leaderboard/
│   │   └── settings/
│   └── widgets/
│       ├── common/
│       └── custom/
│
├── config/
│   ├── routes/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   └── theme/
│       └── app_theme.dart
│
└── main.dart
```

### Key Directories Explanation

#### core/
Contains fundamental utilities, constants, and shared functionality used throughout the app.

#### data/
Handles data operations, including:
- Data sources (local and remote)
- Data models
- Repository implementations

#### domain/
Contains business logic and entities:
- Business entities
- Repository interfaces
- Use cases

#### presentation/
UI-related code:
- BLoC pattern implementation
- Pages/screens
- Reusable widgets

#### config/
App-wide configuration:
- Routing
- Theming
- Environment variables
