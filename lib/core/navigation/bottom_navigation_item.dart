import 'package:flutter/material.dart';

class BottomNavigationItem {
  final String label;
  final String route;
  final IconData icon;
  final IconData selectedIcon;

  const BottomNavigationItem({
    required this.label,
    required this.route,
    required this.icon,
    required this.selectedIcon,
  });
}
