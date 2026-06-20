import 'package:music_sync/core/common/constants/api_endpoints.dart';
import 'package:music_sync/core/locator.dart';
import 'package:music_sync/core/network/dio_service.dart';
import 'package:music_sync/core/utils/either.dart';
import 'package:music_sync/features/auth/model/register_response_model.dart';

class AuthRepository {
  final DioService _dioService;

  AuthRepository(this._dioService);

  Future<Either<String, RegisterResponseModel>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );
      for (var i in _dioService.dio.interceptors) {
        print(i.runtimeType);
      }

      if (response.statusCode == 200) {
        return Right(RegisterResponseModel.fromJson(response.data['data']));
      }
      return Left(response.data['message']);
    } catch (e) {
      return Left('Failed to login');
    }
  }

  Future<Either<String, void>> register(
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.register,
        data: {'email': email, 'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to register');
    } catch (e) {
      return Left('Failed to register');
    }
  }

  Future<Either<String, void>> verifyEmail(String email, String code) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.verifyEmail,
        data: {'email': email, 'code': code},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to verify email');
    } catch (e) {
      return Left('Failed to verify email');
    }
  }

  Future<Either<String, void>> resendOtp(String email) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.resendOtp,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to resend OTP');
    } catch (e) {
      return Left('Failed to resend OTP');
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      final response = await _dioService.post(ApiEndpoints.logout);

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to logout');
    } catch (e) {
      return Left('Failed to logout');
    }
  }

  Future<Either<String, void>> forgotPassword(String email) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to send reset link');
    } catch (e) {
      return Left('Failed to send reset link');
    }
  }

  Future<Either<String, void>> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.resetPassword,
        data: {'email': email, 'code': code, 'new_password': newPassword},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to reset password');
    } catch (e) {
      return Left('Failed to reset password');
    }
  }

  Future<Either<String, void>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.changePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to change password');
    } catch (e) {
      return Left('Failed to change password');
    }
  }

  Future<Either<String, void>> refreshToken(String refreshToken) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? "Failed to refresh Token");
    } catch (e) {
      return Left("Failed to refresh token.");
    }
  }
}
