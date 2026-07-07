// import 'package:vanashree_ngo_application/config/router/route_names/error_route_names.dart';

import 'package:music_sync/config/router/route_names/home_page_route_names.dart';

import 'auth_route_names.dart';

class RouteNames {
  static const startApp = '/';
  static const onboarding = '/onboarding';
  static const language = '/language';
  static final auth = AuthRouteNames();
  static final homepage = HomePageRouteNames();
  // static final error = ErrorRouteNames();
}
