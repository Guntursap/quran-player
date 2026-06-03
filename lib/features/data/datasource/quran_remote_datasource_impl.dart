import 'package:dio/dio.dart';
import 'package:quran_player/core/constants/api_constants.dart';
import 'package:quran_player/features/data/models/surah_model.dart';

import 'quran_remote_datasource.dart';

class QuranRemoteDatasourceImpl implements QuranRemoteDatasource {
  QuranRemoteDatasourceImpl(this._dio); // ✅ Dio diinjek, bukan static

  final Dio _dio;

  @override
  Future<List<SurahModel>> getSurahs() async {
    try {
      final response = await _dio.get(ApiConstants.surahs);
      final List data = response.data['data'];
      return data.map((e) => SurahModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}