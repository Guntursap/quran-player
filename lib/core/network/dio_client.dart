import 'package:dio/dio.dart';
import 'package:quran_player/core/constants/api_constants.dart';

// Dio didaftarkan sebagai singleton di service_locator,
// bukan static class agar mudah di-mock saat testing.
Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}