import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PublishForm extends StatefulWidget {
  const PublishForm({super.key});

  @override
  State<PublishForm> createState() => _PublishFormState();
}

class _PublishFormState extends State<PublishForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Novo Projeto',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 40),
            Text(
              'Nome do Projeto',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.background),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: AppColors.offWhite,
              ),
            ),
            SizedBox(height: 24),
            Text('Descrição', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 8,
              textAlignVertical: TextAlignVertical.top,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.background),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: AppColors.offWhite,
              ),
            ),
            SizedBox(height: 24),
            Text('Tags', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 8),
            TextFormField(
              controller: _tagController,
              onFieldSubmitted: (value) {
                if (value.trim().isEmpty) return;

                context.read<PublishProvider>().addTag(value.trim());
                _tagController.clear();
              },
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.background),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: AppColors.offWhite,
              ),
            ),
            SizedBox(height: 12),
            Consumer<PublishProvider>(
              builder: (context, provider, child) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: provider.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      labelStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: AppColors.background),
                      backgroundColor: AppColors.offWhite,
                      deleteIcon: const Icon(
                        Icons.close,
                        color: AppColors.background,
                      ),
                      onDeleted: () => provider.removeTags(tag),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(152, 51),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Descartar',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.primary),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.delete, size: 24, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final provider = context.read<PublishProvider>();

                      await context.read<PublishProvider>().publish(
                        title: _titleController.text.trim(),
                        body: _descriptionController.text.trim(),
                        markdown: '',
                        image: provider.selectedImage!,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Publicar',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.background),
                        ),
                        SizedBox(height: 12),
                        Icon(
                          Icons.publish,
                          size: 24,
                          color: AppColors.background,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}
