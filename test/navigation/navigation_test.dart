import 'package:flutter_test_app/navigation/app_navigation_stack.dart';
import 'package:flutter_test_app/navigation/navigation_route_information_parser.dart';
import 'package:flutter_test_app/navigation/navigation_stack_item.dart';
import 'package:test/test.dart';

void main() {
  group('AppNavigationStack -', () {
    test('instance is initialized and have items', () async {
      expect(AppNavigationStack.instance, isNotNull);
      expect(AppNavigationStack.instance.items.length, isPositive);
    });
  });

  group('NavigationRouteInformationParser -', () {
    const artObjectListSegment = 'artObjectList';
    const errorPathSegment = 'errorPathSegment';

    late NavigationRouteInformationParser parser;

    setUp(() {
      parser = NavigationRouteInformationParser();
    });

    test('itemForPathSegments return correct navigation stack items', () async {
      final artObjectListStackItem =
          await parser.itemForPathSegments([artObjectListSegment]);
      expect(
        artObjectListStackItem,
        equals(const NavigationStackItem.artObjectList()),
      );
      final notFoundStackItem =
          await parser.itemForPathSegments([errorPathSegment]);
      expect(
        notFoundStackItem,
        equals(const NavigationStackItem.notFound(
            pathSegments: [errorPathSegment])),
      );
    });

    test('pathSegmentsForItem return correct url segments', () async {
      final artObjectListSegments = parser.pathSegmentsForItem(
        const NavigationStackItem.artObjectList(),
      );
      expect(artObjectListSegments, equals([artObjectListSegment]));
      final notFoundSegments = parser.pathSegmentsForItem(
        const NavigationStackItem.notFound(pathSegments: [errorPathSegment]),
      );
      expect(notFoundSegments, equals([errorPathSegment]));
    });
  });
}
