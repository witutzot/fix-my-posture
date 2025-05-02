import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String workoutId;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutId,
  });

  @override
  ConsumerState<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://example.com/workout-image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upper Back Strengthening',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        context,
                        icon: Icons.timer_outlined,
                        label: '15 minutes',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        context,
                        icon: Icons.fitness_center,
                        label: 'Intermediate',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This workout focuses on strengthening your upper back muscles to improve posture and reduce neck and shoulder tension. Perfect for office workers and anyone who spends long hours sitting.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Exercises',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildExerciseList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _startWorkout,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Start Workout'),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return Column(
      children: [
        _buildExerciseItem(
          title: 'Scapular Retraction',
          duration: '2 minutes',
          description: 'Squeeze your shoulder blades together and hold.',
        ),
        const Divider(),
        _buildExerciseItem(
          title: 'Wall Angels',
          duration: '3 minutes',
          description: 'Stand with your back against the wall and move your arms up and down.',
        ),
        const Divider(),
        _buildExerciseItem(
          title: 'Prone Y Exercise',
          duration: '2 minutes',
          description: 'Lie face down and raise your arms in a Y position.',
        ),
      ],
    );
  }

  Widget _buildExerciseItem({
    required String title,
    required String duration,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.fitness_center,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startWorkout() async {
    setState(() => _isLoading = true);
    // TODO: Implement workout start logic
    await Future.delayed(const Duration(seconds: 1)); // Simulated delay
    if (mounted) {
      setState(() => _isLoading = false);
      // TODO: Navigate to workout session screen
    }
  }
} 