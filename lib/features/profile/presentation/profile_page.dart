import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:code_connect_app/shared/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyLight, width: 2),
              ),
              child: CircleAvatar(
                radius: 68,
                backgroundColor: AppColors.greyLight,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '@teste',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(width: 16),
                OutlinedButtonWidget(
                  color: AppColors.greyLight,
                  size: Size(107, 51),
                  buttonTitle: 'Seguir',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nome Teste',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.greyMedium),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '3 Projetos',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.greyMedium),
                ),
                const SizedBox(width: 16),
                Text(
                  '25 Conexões',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.greyMedium),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(),
          ],
        ),
      ),
    );
  }
}
