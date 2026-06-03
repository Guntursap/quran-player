part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvent {}

final class LoadAudio extends AudioPlayerEvent {
  final int surahNumber;
  LoadAudio(this.surahNumber);
}

final class PlayAudio extends AudioPlayerEvent {}

final class PauseAudio extends AudioPlayerEvent {}

final class SeekAudio extends AudioPlayerEvent {
  final Duration position;
  SeekAudio(this.position);
}

// Event internal untuk merespons stream dari just_audio
final class _UpdatePosition extends AudioPlayerEvent {
  final Duration position;
  _UpdatePosition(this.position);
}

final class _UpdateDuration extends AudioPlayerEvent {
  final Duration duration;
  _UpdateDuration(this.duration);
}

final class _UpdatePlayingState extends AudioPlayerEvent {
  final bool isPlaying;
  _UpdatePlayingState(this.isPlaying);
}