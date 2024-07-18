import 'package:assignment/src/constants/routing_constants.dart';
import 'package:assignment/src/features/home/home_screen.dart';
import 'package:assignment/src/features/login/login_screen.dart';
import 'package:assignment/src/features/register/register_screen.dart';
import 'package:assignment/src/features/splash/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///RoutingConfig - Handle Routing of application
class RoutingConfig {
  static GoRouter router = GoRouter(
    initialLocation: RoutingConstants.initial,
    routes: <GoRoute>[
      GoRoute(
        path: RoutingConstants.initial,
        name: RoutingConstants.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.login,
        name: RoutingConstants.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.register,
        name: RoutingConstants.register,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.home,
        name: RoutingConstants.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
    observers: <NavigatorObserver>[
      BotToastNavigatorObserver(),
    ],
  );
}
