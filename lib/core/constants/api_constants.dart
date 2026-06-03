abstract final class ApiConstants {
  static const baseUrl = 'https://api.alquran.cloud/v1';

  static const surahs = '/surah';

  // Audio URL — dipindahkan dari AudioPlayerBloc ke sini
  static String audioUrl(int surahNumber) =>
      'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$surahNumber.mp3';
}