import 'package:code_connect_app/core/routes/routes.dart';
import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? widget;
  const CustomAppBar({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.grafite,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 110,
      centerTitle: true,
      title: Image.asset('assets/images/Logo.png', height: 50),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 32),
          child: OutlinedButton(
            onPressed: () {
              context.push(Routes.publish);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.verdeDestaque, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            ),
            child: Text(
              'Publicar',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(190);
}
