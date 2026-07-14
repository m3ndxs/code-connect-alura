import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchTag extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const SearchTag({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.dark),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close, size: 18, color: AppColors.dark),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
