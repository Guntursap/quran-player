import 'package:quran_player/features/domain/entities/surah_entity.dart';
import 'package:quran_player/features/domain/repositories/quran_repository.dart';

class GetSurahsUseCase {
  GetSurahsUseCase(this._repository);

  final QuranRepository _repository;

  Future<List<SurahEntity>> call() {
    return _repository.getSurahs();
  }
}