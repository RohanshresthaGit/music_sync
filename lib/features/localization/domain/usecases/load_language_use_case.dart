import 'package:music_sync/features/localization/domain/entities/language.dart';
import 'package:music_sync/features/localization/domain/repositories/language_repository.dart';

abstract interface class LoadLanguageUseCase {
  Future<Language?> execute();
}

class LoadLanguageUseCaseImpl implements LoadLanguageUseCase {
  final LanguageRepository _repository;

  LoadLanguageUseCaseImpl(this._repository);

  @override
  Future<Language?> execute() {
    return _repository.loadLanguage();
  }
}
