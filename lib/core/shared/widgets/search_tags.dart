import 'package:code_connect_app/core/shared/widgets/search_tag.dart';
import 'package:flutter/material.dart';

class SearchTags extends StatelessWidget {
  final List<String> tags;
  final String? selectedTag;
  final ValueChanged<String>? onRemove;
  final ValueChanged<String>? onSelect;

  const SearchTags({
    super.key,
    required this.tags,
    this.selectedTag,
    this.onRemove,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tags.map((tag) {
          return SearchTag(
            text: tag,
            isSelected: selectedTag == tag,
            onTap: onSelect != null ? () => onSelect!(tag) : () {},
            onRemove: onRemove != null ? () => onRemove!(tag) : null,
          );
        }).toList(),
      ),
    );
  }
}
