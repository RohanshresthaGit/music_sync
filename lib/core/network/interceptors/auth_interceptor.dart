import 'package:dio/dio.dart';
import 'package:music_sync/core/locator.dart';

class AuthInterceptor extends Interceptor {
  static const String _authTokenKey = 'auth_token';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.getString(_authTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
