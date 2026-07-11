import 'package:code_connect_app/shared/widgets/custom_app_bar.dart';
import 'package:code_connect_app/shared/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: child,
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
