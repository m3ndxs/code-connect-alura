import 'package:code_connect_app/core/providers/text_provider.dart';
import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/aluracontent_concept.png'),
            SizedBox(height: 56),
            Text(
              provider.getText("about", "title"),
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              provider.getText("about", "subtitle"),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 56),
            Text(
              provider.getText("about", "description"),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 56),
            Text(
              provider.getText("about", "title_mission"),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24),
            Text(
              provider.getText("about", "content_mission"),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            Image.asset('assets/images/aluracontent_concept_art_notebook.png'),
            SizedBox(height: 56),
            Text(
              provider.getText("about", "title_join_us"),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24),
            Text(
              provider.getText("about", "content_join_us"),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 56),
            Image.asset('assets/images/icon.png'),
            SizedBox(height: 16),
            Text(
              provider.getText("about", "footer"),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.greyMedium),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}
