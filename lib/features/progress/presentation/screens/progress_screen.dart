import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fix_my_posture/features/progress/presentation/widgets/achievement_card.dart';
import 'package:fix_my_posture/features/progress/presentation/widgets/stats_card.dart';
import 'package:fix_my_posture/features/progress/presentation/widgets/workout_history_card.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatsCard(),
            const SizedBox(height: 24),
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const AchievementCard(
              title: 'Early Bird',
              description: 'Complete 5 workouts before 9 AM',
              progress: 0.6,
              icon: Icons.wb_sunny_outlined,
            ),
            const SizedBox(height: 16),
            const AchievementCard(
              title: 'Consistency King',
              description: 'Maintain a 7-day workout streak',
              progress: 0.8,
              icon: Icons.local_fire_department,
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Workouts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const WorkoutHistoryCard(
              title: 'Upper Back Strengthening',
              date: 'Today, 10:30 AM',
              duration: '15 minutes',
              points: 50,
            ),
            const SizedBox(height: 16),
            const WorkoutHistoryCard(
              title: 'Neck Relief Routine',
              date: 'Yesterday, 2:15 PM',
              duration: '10 minutes',
              points: 30,
            ),
          ],
        ),
      ),
    );
  }
} 