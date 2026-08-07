import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/theme_cubit.dart';
import 'package:weather/core/theme/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDark = state.themeMode == ThemeMode.dark;

          return ListView(
            children: [
              const SizedBox(height: 10),

              ListTile(
                leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                title: const Text("Dark Mode"),
                subtitle: const Text("Enable dark theme"),
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),

              const Divider(),

              const AboutListTile(
                icon: Icon(Icons.info_outline),
                applicationName: "Weather App",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026 Jemson Jacob",
              ),
            ],
          );
        },
      ),
    );
  }
}
