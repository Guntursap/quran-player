import '../models/surah_model.dart';

abstract interface class QuranRemoteDatasource {
  Future<List<SurahModel>> getSurahs();
}