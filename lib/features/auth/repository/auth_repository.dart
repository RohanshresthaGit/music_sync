import 'package:dio/dio.dart';
import 'package:music_sync/core/common/constants/api_endpoints.dart';
import 'package:music_sync/core/network/dio_service.dart';
import 'package:music_sync/core/utils/either.dart';
import 'package:music_sync/features/auth/model/login_response_model.dart';
import 'package:music_sync/features/auth/model/refresh_token_response_model.dart';
import 'package:music_sync/features/auth/model/register_response_model.dart';

class AuthRepository {
  final DioService _dioService;

  AuthRepository(this._dioService);

  Future<Either<String, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return Right(LoginResponseModel.fromJson(response.data['data']));
      }
      return Left(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to login',
      );
    } catch (e) {
      return Left('Failed to login');
    }
  }

  Future<Either<String, RegisterResponseModel>> register(
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
        return Right(RegisterResponseModel.fromJson(response.data['data']));
      }
      return Left(response.data['message'] ?? 'Failed to register');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to register',
      );
    } catch (e) {
      return Left('Failed to register');
    }
  }

  Future<Either<String, bool>> verifyEmail(String email, String code) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.verifyEmail,
        data: {'email': email, 'otp': code},
      );

      if (response.statusCode == 200) {
        return Right(response.data['success']);
      }
      return Left(response.data['message'] ?? 'Failed to verify email');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to verify email',
      );
    } catch (e) {
      return Left('Failed to verify email');
    }
  }

  Future<Either<String, bool>> resendOtp(String email) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.resendOtp,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return Right(response.data['success']);
      }
      return Left(response.data['message'] ?? 'Failed to resend OTP');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to resend OTP',
      );
    } catch (e) {
      return Left('Failed to resend OTP');
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      final response = await _dioService.post(ApiEndpoints.logout);

      if (response.statusCode == 200) {
        return Right(response.data['success']);
      }
      return Left(response.data['message'] ?? 'Failed to logout');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to logout',
      );
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
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to send reset link',
      );
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
        data: {'email': email, 'otp': code, 'newPassword': newPassword},
      );

      if (response.statusCode == 200) {
        return Right(null);
      }
      return Left(response.data['message'] ?? 'Failed to reset password');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to reset password',
      );
    } catch (e) {
      return Left('Failed to reset password');
    }
  }

  Future<Either<String, bool>> changePassword(
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
        return Right(response.data['success']);
      }
      return Left(response.data['message'] ?? 'Failed to change password');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to change password',
      );
    } catch (e) {
      return Left('Failed to change password');
    }
  }

  Future<Either<String, RefreshTokenResponseModel>> refreshToken(
    String refreshToken,
  ) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final payload = response.data is Map<String, dynamic>
            ? response.data['data'] ?? response.data
            : response.data;
        return Right(RefreshTokenResponseModel.fromJson(payload));
      }
      return Left(response.data['message'] ?? 'Failed to refresh token');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Failed to refresh token',
      );
    } catch (e) {
      return Left('Failed to refresh token.');
    }
  }
}
