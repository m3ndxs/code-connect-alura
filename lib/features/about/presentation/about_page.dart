import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:code_connect_app/features/about/presentation/cubit/about_cubit.dart';
import 'package:code_connect_app/features/about/presentation/cubit/about_state.dart';
import 'package:code_connect_app/features/about/repositories/about_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutCubit>(
      create: (context) => AboutCubit(AboutRepository())..loadAboutData(),
      child: Scaffold(
        body: BlocBuilder<AboutCubit, AboutState>(
          builder: ((context, state) {
            if (state is AboutLoading || state is AboutInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AboutError) {
              return Center(child: Text(state.message));
            }
            if (state is AboutLoaded) {
              final data = state.data;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/aluracontent_concept.png'),
                      SizedBox(height: 56),
                      Text(
                        data['title'],
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: AppTheme.verdeDestaque),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      Text(
                        data['subtitle'],
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.cinzaClaro,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 56),
                      Text(
                        data['description'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 56),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          data['title_mission'],
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppTheme.cinzaClaro),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        data['content_mission'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 24),
                      Image.asset(
                        'assets/images/aluracontent_concept_art_notebook.png',
                      ),
                      SizedBox(height: 56),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          data['title_join_us'],
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppTheme.cinzaClaro),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        data['content_join_us'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 56),
                      Image.asset('assets/images/icon.png'),
                      SizedBox(height: 16),
                      Text(
                        data['footer'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.cinzaMedio,
                        ),
                      ),
                      SizedBox(height: 56),
                    ],
                  ),
                ),
              );
            }

            return SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
