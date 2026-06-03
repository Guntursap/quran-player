import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_player/features/domain/entities/surah_entity.dart';
import 'package:quran_player/features/domain/usecases/get_surah_usecase.dart';

part 'quran_player_event.dart';
part 'quran_player_state.dart';

class QuranPlayerBloc extends Bloc<QuranPlayerEvent, QuranPlayerState> {
  QuranPlayerBloc(this._getSurahsUseCase) : super(const QuranPlayerState()) {
    on<GetSurahs>(_onGetSurahs);
    on<SearchSurah>(_onSearchSurah);
  }

  final GetSurahsUseCase _getSurahsUseCase; // ✅ bukan repository langsung

  Future<void> _onGetSurahs(
    GetSurahs event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: QuranStatus.loading));

      final result = await _getSurahsUseCase(); // ✅ panggil use case

      emit(state.copyWith(
        status: QuranStatus.success,
        surahs: result,
        filteredSurahs: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: QuranStatus.error,
        message: e.toString(),
      ));
    }
  }

  void _onSearchSurah(
    SearchSurah event,
    Emitter<QuranPlayerState> emit,
  ) {
    final keyword = event.keyword.toLowerCase();

    final filtered = state.surahs.where((surah) {
      return surah.name.toLowerCase().contains(keyword) ||
          surah.englishName.toLowerCase().contains(keyword);
    }).toList();

    emit(state.copyWith(filteredSurahs: filtered));
  }
}