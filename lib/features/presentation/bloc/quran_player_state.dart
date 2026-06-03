part of 'quran_player_bloc.dart';

enum QuranStatus {
  initial,
  loading,
  success,
  error,
}

class QuranPlayerState {
  const QuranPlayerState({
    this.status = QuranStatus.initial,
    this.surahs = const [],
    this.filteredSurahs = const [],
    this.message = '',
  });

  final QuranStatus status;
  final List<SurahEntity> surahs;
  final List<SurahEntity> filteredSurahs;
  final String message;

  QuranPlayerState copyWith({
    QuranStatus? status,
    List<SurahEntity>? surahs,
    List<SurahEntity>? filteredSurahs,
    String? message,
  }) {
    return QuranPlayerState(
      status: status ?? this.status,
      surahs: surahs ?? this.surahs,
      filteredSurahs:
          filteredSurahs ?? this.filteredSurahs,
      message: message ?? this.message,
    );
  }
}