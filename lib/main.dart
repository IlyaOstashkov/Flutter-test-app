import 'package:flutter/material.dart';
import 'package:test_app_blocs/test_app_blocs.dart';

import 'navigation/app_navigation_stack.dart';
import 'navigation/navigation_route_information_parser.dart';
import 'navigation/navigation_router_delegate.dart';

void main() {
  BlocDIContainer.instance.initialise();
  runApp(
    MaterialApp.router(
      routerDelegate: NavigationRouterDelegate(
        stack: AppNavigationStack.instance,
      ),
      routeInformationParser: NavigationRouteInformationParser(),
    ),
  );
}
