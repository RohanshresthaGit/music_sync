class ApiEndpoints {
  static const String baseUrl = 'http://192.168.254.33:8080/api/v1';

  static const String auth = '$baseUrl/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String logout = '$auth/logout';
  static const String verifyEmail = '$auth/verify-email';
  static const String resendOtp = '$auth/resend-otp';
  static const String forgotPassword = '$auth/forgot-password';
  static const String changePassword = '$auth/change-password';
  static const String resetPassword = '$auth/reset-password';
  static const String refreshToken = '$auth/refresh-token';
}
