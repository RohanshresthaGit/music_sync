import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_sync/config/router/app_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';

void main() {
  test('launch notifier handles app launch locations only once', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appLaunchNotifierProvider.notifier);

    expect(notifier.isAppLaunchLocation(RouteNames.startApp), isTrue);
    expect(notifier.isAppLaunchLocation('/'), isTrue);
    expect(notifier.isAppLaunchLocation('/login'), isFalse);

    expect(notifier.shouldHandle(RouteNames.startApp), isTrue);
    expect(notifier.shouldHandle(RouteNames.startApp), isFalse);
    expect(notifier.shouldHandle('/'), isFalse);
  });
}
