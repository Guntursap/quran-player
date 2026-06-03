// ✅ File ini ada di features/data/repositories/ (bukan domain!)
import 'package:quran_player/features/data/datasource/quran_remote_datasource.dart';
import 'package:quran_player/features/domain/entities/surah_entity.dart';
import 'package:quran_player/features/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  QuranRepositoryImpl(this._datasource);

  final QuranRemoteDatasource _datasource;

  @override
  Future<List<SurahEntity>> getSurahs() {
    return _datasource.getSurahs();
  }
}