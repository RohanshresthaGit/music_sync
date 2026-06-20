import 'package:go_router/go_router.dart';
import 'package:music_sync/features/auth/view/login_view.dart';
import 'package:music_sync/features/auth/view/register_view.dart';
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
    path: RouteNames.auth.verifyEmail,
    builder: (context, state) => const VerifyEmailView(),
  ),
  // GoRoute(path: RouteNames.auth.register, builder: (context, state) => const RegisterView()),
  // GoRoute(path: RouteNames.auth.forgotPassword, builder: (context, state) => const ForgotPasswordView()),
];
