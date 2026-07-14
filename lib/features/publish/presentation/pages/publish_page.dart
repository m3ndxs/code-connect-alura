import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:code_connect_app/shared/layout/main_layout.dart';
import 'package:code_connect_app/shared/widgets/custom_search_bar.dart';
import 'package:code_connect_app/shared/widgets/search_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PublishProvider>();

    return MainLayout(
      showBottomNavigation: false,
      child: Center(
        child: Column(
          children: [
            CustomSearchBar(
              onSubmitted: (text) {
                provider.addTag(text);
              },
            ),
            const SizedBox(height: 16),
            SearchTags(tags: provider.tags, onRemove: provider.removeTags),
            if (provider.tags.isNotEmpty)
              Align(
                alignment: AlignmentGeometry.center,
                child: TextButton(
                  onPressed: provider.clearTags,
                  child: Text(
                    'Limpar tudo',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            SizedBox(height: 60),
            Text('Publish'),
          ],
        ),
      ),
    );
  }
}
