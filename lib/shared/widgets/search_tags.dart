import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:code_connect_app/shared/widgets/search_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTags extends StatelessWidget {
  final List<String> tags;
  final ValueChanged<String>? onRemove;

  const SearchTags({super.key, required this.tags, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PublishProvider>();
    if (tags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tags.map((tag) {
          return SearchTag(
            text: tag,
            isSelected: provider.selectedTag == tag,
            onTap: () => provider.selectTag(tag),
            onRemove: () => provider.removeTags(tag),
          );
        }).toList(),
      ),
    );
  }
}
