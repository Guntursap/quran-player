import '../../domain/entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel({
    required super.number,
    required super.name,
    required super.englishName,
    required super.englishNameTranslation,
    required super.numberOfAyahs,
  });

  factory SurahModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SurahModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation:
          json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
    );
  }
}