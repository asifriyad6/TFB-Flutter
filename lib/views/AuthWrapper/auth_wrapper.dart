import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/views/AuthScreen/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (authService) {
        if (authService.isAuthenticated.value) {
          return child;
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
