import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/routes/home_page_routes.dart';
import 'package:music_sync/core/common/constants/secure_storage_constants.dart';

import '../../core/common/pages/error_page.dart';
import '../../core/locator.dart';
import '../../features/localization/presentation/views/language_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import 'route_names/route_names.dart';
import 'routes/auth_routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appLaunchRedirectLocations = <String>[RouteNames.startApp, '/'];

final appLaunchNotifierProvider = NotifierProvider<AppLaunchNotifier, bool>(
  AppLaunchNotifier.new,
);

class AppLaunchNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  bool isAppLaunchLocation(String location) {
    return appLaunchRedirectLocations.contains(location);
  }

  bool shouldHandle(String location) {
    if (!isAppLaunchLocation(location)) {
      return false;
    }

    if (state) {
      return false;
    }

    state = true;
    return true;
  }

  Future<String?> resolveLaunchRoute(String location) async {
    if (!shouldHandle(location)) {
      return null;
    }

    final results = await Future.wait([
      secureStorage.getBool(SecureStorageConstants.onboardingSeen),
      secureStorage.getString('auth_token'),
    ]);

    final onboardingSeen = results[0] as bool?;
    final accessToken = results[1] as String?;

    if (onboardingSeen != true) {
      return RouteNames.onboarding;
    }

    if (accessToken != null && accessToken.isNotEmpty) {
      return RouteNames.homepage.homepage;
    }

    return RouteNames.auth.login;
  }

  void reset() {
    state = false;
  }
}

class _RedirectSplashPage extends StatelessWidget {
  const _RedirectSplashPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  setupLocator();

  final location = state.matchedLocation;
  final container = ProviderScope.containerOf(context, listen: false);
  final appLaunchNotifier = container.read(appLaunchNotifierProvider.notifier);

  return appLaunchNotifier.resolveLaunchRoute(location);
}

final router = GoRouter(
  initialLocation: RouteNames.startApp,
  redirect: _redirect,
  navigatorKey: kDebugMode ? ChuckerFlutter.navigatorKey : navigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.startApp,
      builder: (context, state) => const _RedirectSplashPage(),
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
    ...homepageRoutes,
    // ...errorRoutes,
  ],
  errorBuilder: (context, state) => ErrorView(message: state.error!.message),
);
