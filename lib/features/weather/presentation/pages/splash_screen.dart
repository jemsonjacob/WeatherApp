import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff64B5F6), Color(0xff1976D2)],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                const Spacer(),

                Lottie.asset("assets/animation/weather.json", width: 230),

                const SizedBox(height: 20),

                Text(
                  "Weather App",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Real-time Weather at Your Fingertips",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                const SizedBox(
                  width: 35,
                  height: 35,
                  child: CupertinoActivityIndicator(color: Colors.white),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Powered by OpenWeatherMap",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
