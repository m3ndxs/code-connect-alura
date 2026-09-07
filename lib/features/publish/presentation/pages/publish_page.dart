import 'package:code_connect_app/core/routes/routes.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:code_connect_app/features/publish/presentation/widgets/image_picker_card.dart';
import 'package:code_connect_app/features/publish/presentation/widgets/publish_form.dart';
import 'package:code_connect_app/shared/layout/main_layout.dart';
import 'package:code_connect_app/shared/widgets/custom_search_bar.dart';
import 'package:code_connect_app/shared/widgets/search_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBottomNavigation: false,
      child: BlocConsumer<PublishBloc, PublishState>(
        listener: (context, state) {
          if (state.status == PublishStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Publicação realizada com sucesso!'),
              ),
            );
            context.read<PublishBloc>().add(ClearTagsEvent());
            context.read<PublishBloc>().add(RemoveImageEvent());
            context.go(Routes.feed);
          } else if (state.status == PublishStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Erro ao publicar')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  CustomSearchBar(
                    onSubmitted: (text) {
                      context.read<PublishBloc>().add(AddTagEvent(text));
                    },
                  ),
                  const SizedBox(height: 16),
                  SearchTags(
                    tags: state.tags,
                    selectedTag: state.selectedTag,
                    onRemove: (tag) {
                      context.read<PublishBloc>().add(RemoveTagEvent(tag));
                    },
                    onSelect: (tag) {
                      context.read<PublishBloc>().add(SelectTagEvent(tag));
                    },
                  ),
                  if (state.tags.isNotEmpty)
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: TextButton(
                        onPressed: () {
                          context.read<PublishBloc>().add(ClearTagsEvent());
                        },
                        child: Text(
                          'Limpar tudo',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  SizedBox(height: 60),
                  ImagePickerCard(
                    selectedImage: state.selectedImage,
                    onPickImage: () {
                      context.read<PublishBloc>().add(PickImageEvent());
                    },
                    onRemoveImage: () {
                      context.read<PublishBloc>().add(RemoveImageEvent());
                    },
                  ),
                  PublishForm(
                    tags: state.tags,
                    onAddTag: (tag) {
                      context.read<PublishBloc>().add(AddTagEvent(tag));
                    },
                    onRemoveTag: (tag) {
                      context.read<PublishBloc>().add(RemoveTagEvent(tag));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
