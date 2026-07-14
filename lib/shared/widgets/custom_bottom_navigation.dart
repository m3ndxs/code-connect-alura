import 'package:code_connect_app/shared/navigation/navigation_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int currentIndex = navigationItems.indexWhere(
      (item) => item.route == location,
    );

    if (currentIndex == -1) {
      currentIndex = 0;
    }

    return NavigationBar(
      selectedIndex: currentIndex,

      onDestinationSelected: (index) {
        context.go(navigationItems[index].route);
      },

      destinations: navigationItems.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: item.label,
        );
      }).toList(),
    );
  }
}
