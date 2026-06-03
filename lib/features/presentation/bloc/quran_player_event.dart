part of 'quran_player_bloc.dart';

sealed class QuranPlayerEvent {}

final class GetSurahs extends QuranPlayerEvent {}

final class SearchSurah extends QuranPlayerEvent {
  SearchSurah(this.keyword);

  final String keyword;
}