import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  String get currentRoutePath {
    final lastMatch = routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final routePath = matchList.uri.toString();

    return routePath;
  }
}
