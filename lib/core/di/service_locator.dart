import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quran_player/core/network/dio_client.dart';
import 'package:quran_player/features/data/datasource/quran_remote_datasource.dart';
import 'package:quran_player/features/data/datasource/quran_remote_datasource_impl.dart';
import 'package:quran_player/features/domain/repositories/quran_repository.dart';
import 'package:quran_player/features/domain/repositories/quran_repository_impl.dart';
import 'package:quran_player/features/domain/usecases/get_surah_usecase.dart';
import 'package:quran_player/features/presentation/bloc/audio_player/audio_player_bloc.dart';
import 'package:quran_player/features/presentation/bloc/quran_player_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(createDio());

  getIt.registerSingleton<QuranRemoteDatasource>(
    QuranRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerSingleton<QuranRepository>(
    QuranRepositoryImpl(getIt<QuranRemoteDatasource>()),
  );

  // Use Cases
  getIt.registerSingleton<GetSurahsUseCase>(
    GetSurahsUseCase(getIt<QuranRepository>()),
  );

  // BLoCs
  getIt.registerSingleton<QuranPlayerBloc>(
    QuranPlayerBloc(getIt<GetSurahsUseCase>())..add(GetSurahs()),
  );

  // AudioPlayerBloc sebagai factory agar state selalu fresh tiap masuk PlayerPage
  getIt.registerFactory<AudioPlayerBloc>(
    () => AudioPlayerBloc(),
  );
}