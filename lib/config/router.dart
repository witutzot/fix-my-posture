import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fix_my_posture/features/auth/presentation/screens/login_screen.dart';
import 'package:fix_my_posture/features/auth/presentation/screens/register_screen.dart';
import 'package:fix_my_posture/features/home/presentation/screens/home_screen.dart';
import 'package:fix_my_posture/features/workouts/presentation/screens/workout_list_screen.dart';
import 'package:fix_my_posture/features/workouts/presentation/screens/workout_detail_screen.dart';
import 'package:fix_my_posture/features/progress/presentation/screens/progress_screen.dart';
import 'package:fix_my_posture/features/settings/presentation/screens/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/workouts',
        builder: (context, state) => const WorkoutListScreen(),
      ),
      GoRoute(
        path: '/workouts/:id',
        builder: (context, state) => WorkoutDetailScreen(
          workoutId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/progress',
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}); 