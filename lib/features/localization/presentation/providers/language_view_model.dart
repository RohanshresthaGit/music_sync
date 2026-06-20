import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/features/localization/di/language_di.dart';
import 'package:music_sync/features/localization/domain/entities/language.dart';
import 'package:music_sync/features/localization/domain/usecases/load_language_use_case.dart';
import 'package:music_sync/features/localization/domain/usecases/save_language_use_case.dart';

import '../../../../core/common/constants/constants.dart';

final languageViewModelProvider =
    AsyncNotifierProvider<LanguageViewModel, Language>(LanguageViewModel.new);

class LanguageViewModel extends AsyncNotifier<Language> {
  late final LoadLanguageUseCase _loadLanguageUseCase;
  late final SaveLanguageUseCase _saveLanguageUseCase;

  @override
  Future<Language> build() async {
    _loadLanguageUseCase = ref.watch(loadLanguageUseCaseProvider);
    _saveLanguageUseCase = ref.watch(saveLanguageUseCaseProvider);

    final savedLanguage = await _loadLanguageUseCase.execute();
    return savedLanguage ?? const Language(Constants.en);
  }

  String get code => state.value?.code ?? Constants.en;

  Future<void> changeLanguage(Language language) async {
    state = const AsyncValue.loading();
    await _saveLanguageUseCase.execute(language);
    state = AsyncValue.data(language);
  }
}
