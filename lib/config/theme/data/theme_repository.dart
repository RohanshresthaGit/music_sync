import 'package:flutter/material.dart';

import '../domain/repository/theme_repository.dart';
import 'theme_storage.dart';

class ThemeRepository implements IThemeRepository {
  final IThemeStorage _themeStorage;

  ThemeRepository(this._themeStorage);

  @override
  Future<ThemeMode> loadThemeMode() async {
    return await _themeStorage.loadThemeMode();
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _themeStorage.saveThemeMode(mode);
  }
}
