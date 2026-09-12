import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:code_connect_app/core/shared/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PublishForm extends StatefulWidget {
  final List<String> tags;
  final ValueChanged<String>? onAddTag;
  final ValueChanged<String>? onRemoveTag;

  const PublishForm({
    super.key,
    this.tags = const [],
    this.onAddTag,
    this.onRemoveTag,
  });

  @override
  State<PublishForm> createState() => _PublishFormState();
}

class _PublishFormState extends State<PublishForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 40),
            Text(
              'Nome do Projeto',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.grafite),
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
                fillColor: AppTheme.offWhite,
              ),
            ),
            SizedBox(height: 24),
            Text('Descrição', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 8,
              textAlignVertical: TextAlignVertical.top,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.grafite),
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
                fillColor: AppTheme.offWhite,
              ),
            ),
            SizedBox(height: 24),
            Text('Tags', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            TextFormField(
              controller: _tagController,
              onFieldSubmitted: (value) {
                if (value.trim().isEmpty) return;

                widget.onAddTag?.call(value.trim());
                _tagController.clear();
              },
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.grafite),
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
                fillColor: AppTheme.offWhite,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppTheme.grafite),
                  backgroundColor: AppTheme.offWhite,
                  deleteIcon: const Icon(Icons.close, color: AppTheme.grafite),
                  onDeleted: () => widget.onRemoveTag?.call(tag),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButtonWidget(
                    color: AppTheme.verdeDestaque,
                    size: Size(152, 51),
                    onPressed: () {
                      context.pop();
                    },
                    buttonTitle: 'Descartar',
                    sizedBox: SizedBox(width: 12),
                    iconButton: Icon(
                      Icons.delete,
                      size: 24,
                      color: AppTheme.verdeDestaque,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      context.read<PublishBloc>().add(
                        PublishSubmittedEvent(
                          _titleController.text.trim(),
                          _descriptionController.text.trim(),
                          'teste',
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Publicar',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.grafite),
                        ),
                        SizedBox(height: 12),
                        Icon(Icons.publish, size: 24, color: AppTheme.grafite),
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
