import 'package:go_router/go_router.dart';
import 'package:music_sync/core/common/pages/error_page.dart';
import 'package:music_sync/features/auth/model/otp_arguments.dart';
import 'package:music_sync/features/auth/view/change_password_view.dart';
import 'package:music_sync/features/auth/view/forgot_password_view.dart';
import 'package:music_sync/features/auth/view/login_view.dart';
import 'package:music_sync/features/auth/view/register_view.dart';
import 'package:music_sync/features/auth/view/reset_new_password_view.dart';
import 'package:music_sync/features/auth/view/verify_email_view.dart';

// import '../../../features/auth/presentation/views/login_view.dart';
// import '../../../features/auth/presentation/views/signup_view.dart';
import '../route_names/route_names.dart';

final authRoutes = [
  GoRoute(
    path: RouteNames.auth.login,
    builder: (context, state) => const LoginView(),
  ),
  GoRoute(
    path: RouteNames.auth.register,
    builder: (context, state) => const RegisterView(),
  ),
  GoRoute(
    path: RouteNames.auth.forgotPassword,
    builder: (context, state) => const ForgotPasswordView(),
  ),
  GoRoute(
    path: RouteNames.auth.resetNewPassword,
    builder: (context, state) {
      final args = state.extra;
      return ResetNewPasswordView(email: args as String);
    },
  ),
  GoRoute(
    path: RouteNames.auth.changePassword,
    builder: (context, state) => const ChangePasswordView(),
  ),
  GoRoute(
    path: RouteNames.auth.verifyOtp,
    builder: (context, state) {
      final args = state.extra;

      if (args == null || args is! OtpArguments) {
        return ErrorView(message: "Invalid arguments. Please try again.");
      }
      return VerifyOtpView(args: args);
    },
  ),
  // GoRoute(path: RouteNames.auth.register, builder: (context, state) => const RegisterView()),
  // GoRoute(path: RouteNames.auth.forgotPassword, builder: (context, state) => const ForgotPasswordView()),
];
