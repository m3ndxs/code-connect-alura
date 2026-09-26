import 'package:code_connect_app/core/shared/widgets/custom_card_post.dart';
import 'package:code_connect_app/core/shared/widgets/custom_text_button.dart';
import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:code_connect_app/core/shared/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showProjects = false;

  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, ProfileState state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileSuccess) {
            final user = state.user;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.cinzaClaro,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 68,
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '@${user.username}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 16),
                        OutlinedButtonWidget(
                          color: AppTheme.cinzaClaro,
                          size: Size(107, 51),
                          buttonTitle: 'Seguir',
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppTheme.verdeDestaque),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.cinzaMedio,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '3 Projetos',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.cinzaMedio),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '25 Conexões',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.cinzaMedio),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    const SizedBox(height: 32),
                    CustomTextButton(
                      buttonTitle: 'Meus Projetos',
                      onPressed: () {
                        setState(() => _showProjects = !_showProjects);

                        if (_showProjects) {
                          context.read<PublishBloc>().add(
                            GetPostsByProfileEvent(user.id),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    if (_showProjects) _buildProjectsList(context),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProjectsList(BuildContext context) {
    return BlocBuilder<PublishBloc, PublishState>(
      buildWhen: (previous, current) =>
          previous.posts != current.posts ||
          previous.postsStatus != current.postsStatus,
      builder: (context, state) {
        if (state.postsStatus == PostsStatus.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.postsStatus == PostsStatus.failure) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              state.postsErrorMessage ?? 'Não foi possível carregar.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.cinzaMedio,
              ),
            ),
          );
        }

        if (state.posts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              'Nenhum projeto publicado ainda.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.cinzaMedio),
            ),
          );
        }

        return Column(
          children: [
            for (final post in state.posts) ...[
              CustomCardPost(
                image: post.imageUrl,
                title: post.title,
                body: post.body,
                author: post.author.username,
                authorAvatar: post.author.avatar,
                likes: post.likes,
              ),
              const SizedBox(height: 16),
            ],
          ],
        );
      },
    );
  }
}
