import 'package:code_connect_app/core/strings/app_strings/about_strings.dart';
import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/core/assets/images/aluracontent_concept.png'),
              SizedBox(height: 56),
              Text(
                AboutStrings.welcomeTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.verdeDestaque,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                AboutStrings.pageSubtitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppTheme.cinzaClaro),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 56),
              Text(
                AboutStrings.pageDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 56),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  AboutStrings.missionTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppTheme.cinzaClaro),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 24),
              Text(
                AboutStrings.missionDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              Image.asset(
                'lib/core/assets/images/aluracontent_concept_art_notebook.png',
              ),
              SizedBox(height: 56),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  AboutStrings.joinUsTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppTheme.cinzaClaro),
                ),
              ),
              SizedBox(height: 24),
              Text(
                AboutStrings.joinUsDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 56),
              Image.asset('lib/core/assets/images/icon.png'),
              SizedBox(height: 16),
              Text(
                AboutStrings.clossingMessage,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.cinzaMedio),
              ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
