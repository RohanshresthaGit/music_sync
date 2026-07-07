import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';
import 'package:music_sync/features/auth/view/homepage_view.dart';

final homepageRoutes = [
  GoRoute(
    path: RouteNames.homepage.homepage,
    builder: (context, state) => const HomepageView(),
  ),
];
