import 'package:flutter/material.dart';

import '../repository/theme_repository.dart';

abstract interface class SaveThemeUseCase {
  Future<void> execute(ThemeMode mode);
}

class SaveThemeUseCaseImpl implements SaveThemeUseCase {
  final IThemeRepository _repository;

  SaveThemeUseCaseImpl(this._repository);

  @override
  Future<void> execute(ThemeMode mode) {
    return _repository.saveThemeMode(mode);
  }
}