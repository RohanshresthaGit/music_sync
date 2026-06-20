import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/localization/di/language_di.dart';
import '../data/theme_repository.dart';
import '../data/theme_storage.dart';
import '../domain/repository/theme_repository.dart';
import '../domain/usecases/load_theme_usecase.dart';
import '../domain/usecases/save_theme_usecase.dart';

final themeStorageProvider = Provider<IThemeStorage>((ref) {
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return ThemeStorage(secureStorageService);
});

final themeRepositoryProvider = Provider<IThemeRepository>((ref){
  final themeStorage = ref.watch(themeStorageProvider);
  return ThemeRepository(themeStorage);
});

final loadThemeUseCaseProvider = Provider<LoadThemeUseCase>(
  (ref) {
    final repository = ref.watch(themeRepositoryProvider);
    return LoadThemeUseCaseImpl(repository);
  },
);

final saveThemeUseCaseProvider = Provider<SaveThemeUseCase>(
  (ref) {
    final repository = ref.watch(themeRepositoryProvider);
    return SaveThemeUseCaseImpl(repository);
  },
);