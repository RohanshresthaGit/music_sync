import 'package:music_sync/features/localization/domain/entities/language.dart';
import 'package:music_sync/features/localization/domain/repositories/language_repository.dart';

abstract interface class SaveLanguageUseCase {
  Future<void> execute(Language language);
}

class SaveLanguageUseCaseImpl implements SaveLanguageUseCase {
  final LanguageRepository _repository;

  SaveLanguageUseCaseImpl(this._repository);

  @override
  Future<void> execute(Language language) {
    return _repository.saveLanguage(language);
  }
}
