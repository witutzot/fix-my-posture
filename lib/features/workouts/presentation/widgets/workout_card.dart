import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String duration;
  final String difficulty;
  final String category;
  final String thumbnailUrl;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.category,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        context,
                        icon: Icons.timer_outlined,
                        label: duration,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        context,
                        icon: Icons.fitness_center,
                        label: difficulty,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        context,
                        icon: Icons.category_outlined,
                        label: category,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        horizontal: 8,
        vertical: 4,
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
} 