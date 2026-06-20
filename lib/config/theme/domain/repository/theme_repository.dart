import 'package:flutter/material.dart';

abstract interface class IThemeRepository {
  Future<ThemeMode> loadThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}