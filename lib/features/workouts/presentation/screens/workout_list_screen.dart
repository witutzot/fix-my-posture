import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fix_my_posture/features/workouts/presentation/widgets/workout_card.dart';
import 'package:fix_my_posture/features/workouts/presentation/widgets/category_filter.dart';

class WorkoutListScreen extends ConsumerStatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  ConsumerState<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends ConsumerState<WorkoutListScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: Column(
        children: [
          CategoryFilter(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10, // TODO: Replace with actual workout count
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: WorkoutCard(
                    title: 'Upper Back Strengthening',
                    duration: '15 minutes',
                    difficulty: 'Intermediate',
                    category: 'Back',
                    thumbnailUrl: 'https://example.com/thumbnail.jpg',
                    onTap: () {
                      // TODO: Navigate to workout details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 