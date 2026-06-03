part of 'audio_player_bloc.dart';

enum AudioPlayerStatus {
  initial,
  loading,
  playing,
  paused,
  error,
}

class AudioPlayerState {
  final AudioPlayerStatus status;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final String? errorMessage;

  const AudioPlayerState({
    this.status = AudioPlayerStatus.initial,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.errorMessage,
  });

  AudioPlayerState copyWith({
    AudioPlayerStatus? status,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    String? errorMessage,
  }) {
    return AudioPlayerState(
      status: status ?? this.status,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}