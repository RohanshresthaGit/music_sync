import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/theme_di.dart';
import '../domain/usecases/load_theme_usecase.dart';
import '../domain/usecases/save_theme_usecase.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  late final LoadThemeUseCase _loadThemeUseCase;
  late final SaveThemeUseCase _saveThemeUseCase;

  @override
  ThemeMode build() {
    _loadThemeUseCase = ref.read(loadThemeUseCaseProvider);
    _saveThemeUseCase = ref.read(saveThemeUseCaseProvider);
    _init();

    return ThemeMode.system;
  }

  ThemeMode get theme => state;

  Future<void> _init() async {
    final savedTheme = await _loadThemeUseCase.execute();
    state = savedTheme;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    _saveThemeUseCase.execute(mode);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    state = newMode;
    _saveThemeUseCase.execute(newMode);
  }

  void enableDarkMode() {
    state = ThemeMode.dark;
    _saveThemeUseCase.execute(ThemeMode.dark);
  }

  void enableLightMode() {
    state = ThemeMode.light;
    _saveThemeUseCase.execute(ThemeMode.light);
  }

  void useSystemTheme() {
    state = ThemeMode.system;
    _saveThemeUseCase.execute(ThemeMode.system);
  }
}
