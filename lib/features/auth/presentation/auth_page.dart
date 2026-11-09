import 'package:code_connect_app/core/di/injection_container.dart' as di;
import 'package:code_connect_app/core/routes/routes.dart';
import 'package:code_connect_app/core/shared/layout/main_layout.dart';
import 'package:code_connect_app/core/strings/app_strings/login_strings.dart';
import 'package:code_connect_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:code_connect_app/features/auth/presentation/cubit/login_state.dart';
import 'package:code_connect_app/features/auth/presentation/widgets/container_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<LoginCubit>(),
      child: MainLayout(
        showAppBar: false,
        showBottomNavigation: false,
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(Routes.feed);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 64),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 640),
                      child: ContainerFormAuth(
                        image: 'lib/core/assets/images/login_image.png',
                        title: LoginStrings.loginTitle,
                        subtitle: LoginStrings.welcomeTitle,
                        email: LoginStrings.emailOrUser,
                        emailController: emailController,
                        password: 'Senha',
                        passwordController: passwordController,
                        isLoading: isLoading,
                        onSubmit: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text;

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Preencha e-mail e senha.'),
                              ),
                            );
                            return;
                          }

                          context.read<LoginCubit>().login(
                            email: email,
                            password: password,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
