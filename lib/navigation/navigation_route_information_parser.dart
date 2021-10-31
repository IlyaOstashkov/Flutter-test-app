import 'package:flutter/widgets.dart';
import 'package:pragmatic_navigation/pragmatic_navigation.dart';

import 'navigation_stack_item.dart';

abstract class _PathKeys {
  static const artObjectList = 'artObjectList';
}

class NavigationRouteInformationParser
    extends NavigationStackRouterInformationParser<NavigationStackItem> {
  @override
  Future<NavigationStackItem?> itemForPathSegments(
      List<String> pathSegments) async {
    try {
      final key = pathSegments[0];
      // NOTE: if you want to use object id in path
      // final objectId = pathSegments[1];
      // Also, you can
      NavigationStackItem? item;
      switch (key) {
        case _PathKeys.artObjectList:
          item = const NavigationStackItem.artObjectList();
          break;
        // You can add more path keys to navigate to some object detail by id
      }
      return item ?? NavigationStackItem.notFound(pathSegments: pathSegments);
    } catch (e) {
      return null;
    }
  }

  @override
  List<String> pathSegmentsForItem(NavigationStackItem item) => item.maybeWhen(
        notFound: (pathSegments) => pathSegments,
        artObjectList: () => [_PathKeys.artObjectList],
        // here you can describe path segments to another pages
        orElse: () => [],
      );

  @override
  Future<List<NavigationStackItem>> itemsForRouteInformation(
      RouteInformation routeInformation) async {
    final items = await super.itemsForRouteInformation(routeInformation);
    if (items.isEmpty || items.first is! NavigationStackItemArtObjectList) {
      const fallback = NavigationStackItem.artObjectList();
      if (items.isNotEmpty && items.first is NavigationStackItemNotFound) {
        items[0] = fallback;
      } else {
        items.insert(0, fallback);
      }
    }
    return items;
  }
}
