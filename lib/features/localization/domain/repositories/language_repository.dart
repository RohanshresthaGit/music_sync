import '../entities/language.dart';

abstract interface class LanguageRepository {
  Future<Language?> loadLanguage();
  Future<void> saveLanguage(Language language);
}
