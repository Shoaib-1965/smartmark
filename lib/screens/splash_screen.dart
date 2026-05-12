import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/services/auth_service.dart';
import 'auth/login_page.dart';
import 'manager/dashboard.dart';
import 'employee/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Auto-navigate to Login or Dashboard after 3 seconds
    Timer(const Duration(seconds: 3), () async {
      if (mounted) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String? role = await AuthService().getUserRole(user.uid);
          if (!mounted) return;
          if (role == 'manager') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ManagerDashboard()),
            );
          } else if (role == 'employee') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EmployeeDashboard()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF1A73E8).withValues(
                              alpha: (1.5 - _animation.value) / 0.7 > 0
                                  ? (1.5 - _animation.value) / 0.7
                                  : 0,
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                         return const Icon(Icons.security, size: 50, color: Color(0xFF1A73E8));
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'SmartMark',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D0D0D),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Smart Attendance System',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
