import 'package:flutter/material.dart';

import '../repository/theme_repository.dart';

abstract interface class LoadThemeUseCase {
  Future<ThemeMode> execute();
}

class LoadThemeUseCaseImpl implements LoadThemeUseCase {
  final IThemeRepository _repository;

  const LoadThemeUseCaseImpl(this._repository);

  @override
  Future<ThemeMode> execute() {
    return _repository.loadThemeMode();
  }
}