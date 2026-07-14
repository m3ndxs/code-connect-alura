import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String>? onSubmitted;

  const CustomSearchBar({super.key, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SearchBar(
            onSubmitted: onSubmitted,
            hintText: 'Digite o que você procura',
            hintStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.bodyMedium,
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 8),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(16, 0, 16, 0),
              child: const Icon(Icons.search, color: AppColors.offWhite),
            ),
          ),
        ),
      ],
    );
  }
}
