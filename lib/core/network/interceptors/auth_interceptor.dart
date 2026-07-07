import 'package:dio/dio.dart';
import 'package:music_sync/core/locator.dart';
import 'package:music_sync/features/auth/repository/auth_repository.dart';

class AuthInterceptor extends Interceptor {
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.getString(_authTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await secureStorage.getString(_refreshTokenKey);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final repo = AuthRepository(dioService);
        final response = await repo.refreshToken(refreshToken);
        await response.fold((_) async {}, (tokens) async {
          await secureStorage.saveString(_authTokenKey, tokens.accessToken);
          await secureStorage.saveString(_refreshTokenKey, tokens.refreshToken);

          err.requestOptions.headers['Authorization'] =
              'Bearer ${tokens.accessToken}';
          final retriedResponse = await dioService.dio.fetch(
            err.requestOptions,
          );
          handler.resolve(retriedResponse);
          return;
        });
      }
    }
    handler.next(err);
  }
}
