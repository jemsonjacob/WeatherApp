import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/features/settings/screens/settings_screen.dart';
import 'package:weather/features/weather/presentation/pages/weather_home_screen.dart';
import 'package:weather/features/weather/presentation/pages/weather_search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    WeatherHomeScreen(),
    WeatherSearchScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.45)
                  : Colors.white.withValues(alpha: 0.35),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: _currentIndex,
              indicatorColor: Colors.white.withValues(alpha: 0.25),
              onDestinationSelected: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.wb_sunny_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.wb_sunny_rounded, color: Colors.white),
                  label: 'Weather',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.search_rounded, color: Colors.white),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.settings_rounded, color: Colors.white),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
