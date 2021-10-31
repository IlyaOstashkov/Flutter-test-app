import 'package:flutter/material.dart';
import 'package:flutter_test_app/di_container.dart';

import 'navigation/app_navigation_stack.dart';
import 'navigation/navigation_route_information_parser.dart';
import 'navigation/navigation_router_delegate.dart';

void main() {
  DIContainer.initialise();
  runApp(MaterialApp.router(
    routerDelegate:
        NavigationRouterDelegate(stack: AppNavigationStack.instance),
    routeInformationParser: NavigationRouteInformationParser(),
  ));
}
