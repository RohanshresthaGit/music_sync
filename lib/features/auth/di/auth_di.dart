import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/core/locator.dart';
import 'package:music_sync/features/auth/repository/auth_repository.dart';
import 'package:music_sync/features/auth/view_model/auth_state.dart';
import 'package:music_sync/features/auth/view_model/auth_view_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(dioService);
});

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);
