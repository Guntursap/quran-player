import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_player/core/di/service_locator.dart';
import 'package:quran_player/features/domain/entities/surah_entity.dart';
import 'package:quran_player/features/presentation/bloc/audio_player/audio_player_bloc.dart';
import 'package:quran_player/features/presentation/widgets/audio_progress.dart';
import 'package:quran_player/features/presentation/widgets/player_controls.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key, required this.surah});

  final SurahEntity surah;

  @override
  Widget build(BuildContext context) {
    // ✅ BlocProvider lokal agar tiap PlayerPage punya instance AudioPlayerBloc sendiri
    return BlocProvider<AudioPlayerBloc>(
      create: (_) => getIt<AudioPlayerBloc>()..add(LoadAudio(surah.number)),
      child: _PlayerView(surah: surah),
    );
  }
}

class _PlayerView extends StatelessWidget {
  const _PlayerView({required this.surah});

  final SurahEntity surah;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Artwork
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 48),

            // Info Surah
            Text(
              surah.englishName,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Surah ${surah.number} • ${surah.numberOfAyahs} Ayahs',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 48),

            // Player Controls
            BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
              builder: (context, state) {
                if (state.status == AudioPlayerStatus.error) {
                  return _ErrorView(message: state.errorMessage ?? 'Unknown error');
                }

                if (state.status == AudioPlayerStatus.loading) {
                  return const _LoadingView();
                }

                final double maxDuration =
                    state.duration.inSeconds > 0
                        ? state.duration.inSeconds.toDouble()
                        : 1.0;

                final double currentPosition =
                    state.position.inSeconds.toDouble().clamp(0.0, maxDuration);

                return Column(
                  children: [
                    // ✅ Pakai widget AudioProgress yang sudah ada
                    AudioProgress(
                      value: currentPosition,
                      max: maxDuration,
                      onChanged: (value) {
                        context.read<AudioPlayerBloc>().add(
                              SeekAudio(Duration(seconds: value.toInt())),
                            );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(state.position)),
                          Text(_formatDuration(state.duration)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ✅ Pakai widget PlayerControls yang sudah ada
                    PlayerControls(
                      isPlaying: state.isPlaying,
                      onPressed: () {
                        if (state.isPlaying) {
                          context.read<AudioPlayerBloc>().add(PauseAudio());
                        } else {
                          context.read<AudioPlayerBloc>().add(PlayAudio());
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text('Loading audio...', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: 16),
        Text(
          'Error: $message',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}