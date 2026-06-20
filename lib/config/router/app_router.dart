import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/pages/error_page.dart';
import '../../features/app_start/presentation/app_start_view.dart';
import '../../features/localization/presentation/views/language_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import 'route_names/route_names.dart';
import 'routes/auth_routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteNames.startApp,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.startApp,
      builder: (context, state) => const AppStartView(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: RouteNames.language,
      builder: (context, state) => const LanguageView(),
    ),
    ...authRoutes,
    // ...errorRoutes,
  ],
  errorBuilder: (context, state) => ErrorPage(message: state.error!.message),
);
