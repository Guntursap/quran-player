import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_player/core/di/service_locator.dart';
import 'package:quran_player/features/presentation/bloc/quran_player_bloc.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_cubit.dart';

class QuranPlayerApp extends StatelessWidget {
  const QuranPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<QuranPlayerBloc>(
          // ✅ GetSurahs sudah di-trigger di service_locator, tidak perlu di sini
          create: (_) => getIt<QuranPlayerBloc>(),
        ),
        // ✅ AudioPlayerBloc DIHAPUS dari sini.
        // Karena registerFactory, tiap PlayerPage buat instance baru via BlocProvider lokal.
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Quran Player',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}