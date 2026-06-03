import '../entities/surah_entity.dart';

abstract interface class QuranRepository {
  Future<List<SurahEntity>> getSurahs();
}