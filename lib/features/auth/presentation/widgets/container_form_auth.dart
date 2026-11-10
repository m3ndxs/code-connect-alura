import 'package:code_connect_app/core/shared/widgets/custom_default_button.dart';
import 'package:code_connect_app/core/shared/widgets/custom_password_form_field.dart';
import 'package:code_connect_app/core/shared/widgets/custom_text_form_field.dart';
import 'package:code_connect_app/core/strings/app_strings/login_strings.dart';
import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ContainerFormAuth extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String? name;
  final String email;
  final String password;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final bool isLoading;

  const ContainerFormAuth({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.name,
    required this.email,
    required this.password,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.cinzaEscuro,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 0.825,
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  textContainer(
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  SizedBox(height: 24),
                  textContainer(
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            textContainer(
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
            ),
            CustomTextFormField(controller: emailController),
            SizedBox(height: 16),
            textContainer(
              Text(password, style: Theme.of(context).textTheme.bodyMedium),
            ),
            CustomPasswordFormField(passwordController: passwordController),
            SizedBox(height: 32),
            CustomDefaultButton(
              color: AppTheme.verdeDestaque,
              size: Size(296, 51),
              buttonTitle: LoginStrings.buttonLogin,
              sizedBox: SizedBox(width: 8),
              iconButton: Icon(
                Icons.arrow_forward_outlined,
                color: AppTheme.grafite,
              ),
              onPressed: isLoading ? null : onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget textContainer(Widget text) {
    return SizedBox(width: double.infinity, child: text);
  }
}
