import 'package:code_connect_app/core/routes/routes.dart';
import 'package:code_connect_app/shared/navigation/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

const navigationItems = [
  BottomNavigationItem(
    label: 'Feed',
    route: Routes.feed,
    icon: Icons.description_outlined,
    selectedIcon: Icons.description,
  ),
  BottomNavigationItem(
    label: 'Perfil',
    route: Routes.profile,
    icon: Icons.person_outlined,
    selectedIcon: Icons.person,
  ),
  BottomNavigationItem(
    label: 'Sobre',
    route: Routes.about,
    icon: Icons.info_outlined,
    selectedIcon: Icons.info,
  ),
  BottomNavigationItem(
    label: 'Sair',
    route: Routes.feed,
    icon: Icons.logout_outlined,
    selectedIcon: Icons.logout,
  ),
];
