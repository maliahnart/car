import 'package:car/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/login_screen.dart';

class AppRouter{
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(path: '/login',
      builder: (BuildContext context, GoRouterState state){
        return const LoginScreen();
      }
      ),
      GoRoute(path: '/home',
      builder: (BuildContext context, GoRouterState state){
        return const HomeScreen();
      })
    ],
  );
}