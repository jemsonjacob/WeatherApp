import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/core/theme/theme_cubit.dart';
import 'package:weather/core/theme/theme_state.dart';
import 'package:weather/features/weather/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/search_bloc/search_weather_bloc.dart';
import 'package:weather/features/weather/presentation/pages/main_screen.dart';
import 'package:weather/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => sl<HomeBloc>()),
        BlocProvider<SearchWeatherBloc>(create: (_) => sl<SearchWeatherBloc>()),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
