import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/core/common/services/secure_storage_service.dart';
import 'package:music_sync/core/locator.dart';
import 'package:music_sync/features/auth/di/auth_di.dart';
import 'package:music_sync/features/auth/model/register_request_model.dart';
import 'package:music_sync/features/auth/repository/auth_repository.dart';
import 'package:music_sync/features/auth/view_model/auth_state.dart';

class AuthViewModel extends Notifier<AuthState> {
  late final AuthRepository _repo;
  late final ISecureStorageService _storage;
  AuthViewModel();

  @override
  AuthState build() {
    _repo = ref.read(authRepositoryProvider);
    _storage = secureStorage;
    return AuthInitial();
  }

  void login(String username, String password) async {
    state = AuthLoading();
    final response = await _repo.login(username, password);
    response.fold(
      (error) {
        state = AuthFailure(error);
      },
      (success) async {
        // persist tokens
        try {
          await _storage.saveString('auth_token', success.accessToken);
          await _storage.saveString('refresh_token', success.refreshToken);
        } catch (_) {}

        state = LoginSuccess(success);
      },
    );
  }

  void register(RegiterRequestModel request) async {
    state = AuthLoading();
    final response = await _repo.register(
      request.email,
      request.username,
      request.password,
    );
    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = RegisterSuccess(data: success),
    );
  }

  void verifyOtp(String email, String code) async {
    state = AuthLoading(); // loading

    final response = await _repo.verifyEmail(email, code);

    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = VerifyEmailSuccess(),
    );
  }

  void resendOtp(String email) async {
    state = AuthLoading();

    final response = await _repo.resendOtp(email);

    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = ResendOtpSuccess(),
    );
  }

  void forgotPassword(String email) async {
    state = AuthLoading();

    final response = await _repo.forgotPassword(email);

    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = ForgotPasswordOtpSent(),
    );
  }

  void resetPassword(String email, String otp, String password) async {
    state = AuthLoading();

    final response = await _repo.resetPassword(email, otp, password);

    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = ResetPasswordSuccess(),
    );
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = AuthLoading();

    final response = await _repo.changePassword(currentPassword, newPassword);

    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = ResetPasswordSuccess(),
    );
  }

  Future<String?> refreshToken(String refreshToken) async {
    final response = await _repo.refreshToken(refreshToken);

    final result = await response.fold<Future<String?>>((error) async => null, (
      tokens,
    ) async {
      try {
        await _storage.saveString('auth_token', tokens.accessToken);
        await _storage.saveString('refresh_token', tokens.refreshToken);
      } catch (_) {}
      return tokens.accessToken;
    });

    return result;
  }
}
