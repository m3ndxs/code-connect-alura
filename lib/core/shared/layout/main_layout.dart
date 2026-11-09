import 'package:code_connect_app/core/shared/widgets/custom_app_bar.dart';
import 'package:code_connect_app/core/shared/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final bool showBottomNavigation;

  const MainLayout({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.showBottomNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? CustomAppBar() : null,
      body: child,
      bottomNavigationBar: showBottomNavigation
          ? const CustomBottomNavigation()
          : null,
    );
  }
}
