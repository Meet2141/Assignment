import 'package:assignment/src/constants/routing_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/service/auth_service.dart';
import 'package:assignment/src/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();

  @override
  void initState() {
    AppUtils.futureDelay(afterDelay: () {
      if (authService.auth.currentUser != null) {
        context.goNamed(RoutingConstants.home);
      } else {
        context.goNamed(RoutingConstants.login);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          StringConstants.appName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
