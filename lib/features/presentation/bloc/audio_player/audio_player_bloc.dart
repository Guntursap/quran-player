import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_player/core/constants/api_constants.dart'; // ✅ URL dari constants

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playingSubscription;

  AudioPlayerBloc() : super(const AudioPlayerState()) {
    on<LoadAudio>(_onLoadAudio);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<SeekAudio>(_onSeekAudio);

    on<_UpdatePosition>(
        (event, emit) => emit(state.copyWith(position: event.position)));
    on<_UpdateDuration>(
        (event, emit) => emit(state.copyWith(duration: event.duration)));
    on<_UpdatePlayingState>(
        (event, emit) => emit(state.copyWith(isPlaying: event.isPlaying)));

    _initStreams();
  }

  void _initStreams() {
    _positionSubscription =
        _audioPlayer.positionStream.listen((position) => add(_UpdatePosition(position)));

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (duration != null) add(_UpdateDuration(duration));
    });

    _playingSubscription =
        _audioPlayer.playingStream.listen((isPlaying) => add(_UpdatePlayingState(isPlaying)));
  }

  Future<void> _onLoadAudio(
      LoadAudio event, Emitter<AudioPlayerState> emit) async {
    try {
      // ✅ Reset position & duration saat ganti surah
      emit(state.copyWith(
        status: AudioPlayerStatus.loading,
        position: Duration.zero,
        duration: Duration.zero,
      ));

      final url = ApiConstants.audioUrl(event.surahNumber); // ✅ URL dari constants
      await _audioPlayer.setUrl(url);

      emit(state.copyWith(status: AudioPlayerStatus.playing));
      await _audioPlayer.play();
    } catch (e) {
      emit(state.copyWith(
        status: AudioPlayerStatus.error,
        errorMessage: 'Failed to load audio: ${e.toString()}',
      ));
    }
  }

  void _onPlayAudio(PlayAudio event, Emitter<AudioPlayerState> emit) {
    _audioPlayer.play();
    emit(state.copyWith(status: AudioPlayerStatus.playing));
  }

  void _onPauseAudio(PauseAudio event, Emitter<AudioPlayerState> emit) {
    _audioPlayer.pause();
    emit(state.copyWith(status: AudioPlayerStatus.paused));
  }

  void _onSeekAudio(SeekAudio event, Emitter<AudioPlayerState> emit) {
    _audioPlayer.seek(event.position);
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playingSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}