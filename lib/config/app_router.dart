import 'package:car/screens/list_car_screen.dart';
import 'package:car/screens/home_screen.dart';
import 'package:car/screens/settings_screen.dart';
import 'package:car/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/custom_color.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: child.currentIndex,
              onTap: child.goBranch,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: CustomColor.primaryBlue,
              unselectedItemColor: Colors.grey[600],
              backgroundColor: Colors.white,
              elevation: 5.0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home_icon_active.png',
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset('assets/images/home_icon_active.png'),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/list_car.png',
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/list_car.png',
                    color: Colors.blue,
                  ),
                  label: 'Danh sách xe',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Cài đặt',
                ),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'list_car',
                    builder: (context, state) => const ListCarScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/list_car',
                builder: (context, state) => const ListCarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
