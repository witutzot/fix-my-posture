import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyProgressCard extends ConsumerWidget {
  const DailyProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProgressIndicator(
                    context,
                    value: 0.75,
                    label: 'Workouts',
                    icon: Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressIndicator(
                    context,
                    value: 0.5,
                    label: 'Reminders',
                    icon: Icons.notifications,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context, {
    required double value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '${(value * 100).toInt()}%',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
} 