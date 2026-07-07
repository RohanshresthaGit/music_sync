import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';

import '../../../core/locator.dart';
import '../utils/app_start_enums.dart';
import 'providers/app_start_view_model.dart';

class AppStartView extends ConsumerStatefulWidget {
  const AppStartView({super.key});

  @override
  ConsumerState<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends ConsumerState<AppStartView> {
  @override
  void initState() {
    super.initState();
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AppStartState>>(appStartViewModelProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            switch (state) {
              case AppStartState.onboarding:
                context.go(RouteNames.onboarding);
                break;
              // case AppStartState.unauthenticated:
              //   context.go(RouteNames.login);
              //   break;
              // case AppStartState.authenticated:
              //   context.go(RouteNames.home);
              //   break;
              // case AppStartState.noInternet:
              //   context.go(RouteNames.noInternet);
              //   break;
              default:
                context.go(RouteNames.auth.login);
            }
          });
        },
        loading: () {},
        error: (_, _) {},
      );
    });
    final state = ref.watch(appStartViewModelProvider);
    return Scaffold(
      body: state.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stack) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Unable to load app state.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        data: (_) => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
