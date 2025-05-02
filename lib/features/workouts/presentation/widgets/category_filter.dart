import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip(context, 'All'),
          _buildCategoryChip(context, 'Back'),
          _buildCategoryChip(context, 'Neck'),
          _buildCategoryChip(context, 'Shoulders'),
          _buildCategoryChip(context, 'Core'),
          _buildCategoryChip(context, 'Quick Fix'),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String category) {
    final isSelected = category == selectedCategory;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(category),
        onSelected: (selected) {
          if (selected) {
            onCategorySelected(category);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        checkmarkColor: Theme.of(context).colorScheme.primary,
        labelStyle: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
} 