import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/features/weather/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation/news.json',
                width: 250,
                height: 250,
              ),

              const SizedBox(height: 20),

              const Text(
                "News Hub",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFFFF7643),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Stay Informed. Stay Connected",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Loading animation
              Lottie.asset(
                'assets/animation/loading.json',
                width: 90,
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
