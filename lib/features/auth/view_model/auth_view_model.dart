import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:music_sync/core/common/services/secure_storage_service.dart';
import 'package:music_sync/core/locator.dart';
import 'package:music_sync/features/auth/di/auth_di.dart';
import 'package:music_sync/features/auth/model/login_request_model.dart';
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

  // void login(String username, String password) async{
  //   state = AuthLoading();
  //   final response = await _repo.login(username, password);
  //   response.fold((error){
  //     state = AuthFailure(error);
  //   }, (success) {
  //     state = AuthSuccess();
  //   });

  // }

  void register(LoginRequestModel request) async {
    state = AuthLoading();
    final response = await _repo.register(
      request.email,
      request.username,
      request.password,
    );
    response.fold(
      (error) => state = AuthFailure(error),
      (success) => state = AuthSuccess(),
    );
  }
  


  // void verifyEmail(String email, String otp) async {
  //   state = AuthLoading();
  //   final response = await _repo.verifyEmail(email, otp);
  //   response.fold((error) => state = AuthFailure(error), (success) {

  //   });
  // }
}
