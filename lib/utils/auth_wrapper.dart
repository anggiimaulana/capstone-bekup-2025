import 'package:capstone/screen/bottom_navigation.dart';
import 'package:capstone/screen/login/login_screen.dart';
import 'package:capstone/service/auth_service.dart';
import 'package:capstone/splash_screen.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulasi delay untuk splash screen
    await Future.delayed(const Duration(seconds: 2));

    try {
      final isLoggedIn = await _authService.isLoggedIn();

      if (mounted) {
        setState(() {
          _isChecking = false;
        });

        // Navigate berdasarkan login status
        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
        // Jika error, default ke login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan splash screen saat checking
    return const SplashScreen();
  }
}