import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_player/app/router/app_router.dart';
import 'package:quran_player/core/widgets/app_loading.dart';
import 'package:quran_player/features/presentation/bloc/quran_player_bloc.dart';
import 'package:quran_player/features/presentation/widgets/search_bar.dart';
import 'package:quran_player/features/presentation/widgets/surah_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quran Player')),
      body: Column(
        children: [
          SearchBarWidget(
            onChanged: (value) {
              context.read<QuranPlayerBloc>().add(SearchSurah(value));
            },
          ),

          const SizedBox(height: 16),

          Expanded(
            child: BlocBuilder<QuranPlayerBloc, QuranPlayerState>(
              builder: (context, state) {
                switch (state.status) {
                  case QuranStatus.loading:
                    return const AppLoading();

                  case QuranStatus.error:
                    return Center(child: Text(state.message));

                  case QuranStatus.success:
                    return ListView.builder(
                      itemCount: state.filteredSurahs.length,
                      itemBuilder: (_, index) {
                        final surah = state.filteredSurahs[index];

                        return SurahTile(
                          title: surah.englishName,
                          subtitle: surah.name,
                          onTap: () {
                            context.push(AppRoutes.player, extra: surah);
                          },
                        );
                      },
                    );

                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
