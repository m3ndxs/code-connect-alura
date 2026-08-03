import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:code_connect_app/shared/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                          color: AppColors.greyLight,
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
                        user.name,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.greyMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '3 Projetos',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.greyMedium),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '25 Conexões',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.greyMedium),
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
          return SizedBox.shrink();
        },
      ),
    );
  }
}

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   late Future<UserEntity> _profileFuture;

//   @override
//   void initState() {
//     super.initState();
//     _profileFuture = context.read<ProfileRepository>().getProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<UserEntity>(
//       future: _profileFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Text(
//             'Erro ${snapshot.error}',
//             style: Theme.of(
//               context,
//             ).textTheme.displayMedium?.copyWith(color: Colors.red),
//           );
//         }
//         if (!snapshot.hasData) {
//           final user = snapshot.data!;
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColors.greyLight, width: 2),
//                     ),
//                     child: CircleAvatar(
//                       radius: 68,
//                       backgroundColor: AppColors.greyLight,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '@${user.name.split(' ').first.toLowerCase()}',
//                         style: Theme.of(context).textTheme.displayMedium,
//                       ),
//                       const SizedBox(width: 16),
//                       OutlinedButtonWidget(
//                         color: AppColors.greyLight,
//                         size: Size(107, 51),
//                         buttonTitle: 'Seguir',
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 32),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'user.name',
//                       style: Theme.of(context).textTheme.headlineMedium
//                           ?.copyWith(color: AppColors.primary),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       color: AppColors.greyMedium,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Text(
//                         '3 Projetos',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: AppColors.greyMedium,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Text(
//                         '25 Conexões',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: AppColors.greyMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Divider(),
//                 ],
//               ),
//             ),
//           );
//         }
//         return const Center(child: Text('Nenhum Dado Encontrado'));
//       },
//     );
//   }
// }
