import 'package:flutter/material.dart';

import '../../../core/common/constants/secure_storage_constants.dart';
import '../../../core/common/services/secure_storage_service.dart';

abstract interface class IThemeStorage {
  Future<ThemeMode> loadThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}

class ThemeStorage implements IThemeStorage {
  final ISecureStorageService _secureStorage;

  const ThemeStorage(this._secureStorage);

  @override
  Future<ThemeMode> loadThemeMode() async {
    final themeModeString = await _secureStorage.getString(
      SecureStorageConstants.themeMode,
    );
    switch (themeModeString) {
      case 'dark':
        return Future.value(ThemeMode.dark);
      case 'light':
        return Future.value(ThemeMode.light);
      case 'system':
        return Future.value(ThemeMode.system);
      default:
        return Future.value(ThemeMode.light); // Default to light if not set
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final themeModeString = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
    return await _secureStorage.saveString(
      SecureStorageConstants.themeMode,
      themeModeString,
    );
  }
}
