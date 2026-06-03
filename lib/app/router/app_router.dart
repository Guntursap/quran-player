// router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:quran_player/features/domain/entities/surah_entity.dart';
import 'package:quran_player/features/presentation/pages/home_page.dart';
import 'package:quran_player/features/presentation/pages/player_page.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const player = '/player';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.player,
      builder: (context, state) {
        // Menerima data SurahEntity dari extra
        final surah = state.extra as SurahEntity;
        return PlayerPage(surah: surah);
      },
    ),
  ],
);