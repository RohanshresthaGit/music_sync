import 'package:music_sync/features/localization/domain/entities/language.dart';
import 'package:music_sync/features/localization/domain/repositories/language_repository.dart';

import 'language_storage.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final ILanguageStorage _languageStorage;

  LanguageRepositoryImpl(this._languageStorage);

  @override
  Future<Language?> loadLanguage() async {
    final code = await _languageStorage.loadLanguage();
    return code == null ? null : Language(code);
  }

  @override
  Future<void> saveLanguage(Language language) async {
    await _languageStorage.saveLanguage(language.code);
  }
}
