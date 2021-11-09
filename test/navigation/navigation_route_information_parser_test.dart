import 'package:flutter/material.dart';
import 'package:flutter_test_app/navigation/navigation_route_information_parser.dart';
import 'package:flutter_test_app/navigation/navigation_stack_item.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRouteInformation extends Mock implements RouteInformation {}

void main() {
  const artObjectListSegment = 'artObjectList';
  const errorPathSegment = 'errorPathSegment';

  group('NavigationRouteInformationParser -', () {
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

    test('itemsForRouteInformation return correct navigation stack items',
        () async {
      const artObjectList = 'artObjectList';
      final mockRouteInformation = MockRouteInformation();
      when(() => mockRouteInformation.location).thenReturn(artObjectList);
      final navigationStackItems =
          await parser.itemsForRouteInformation(mockRouteInformation);
      expect(navigationStackItems, isList);
      expect(navigationStackItems.length, 1);
      expect(
          navigationStackItems.first, isA<NavigationStackItemArtObjectList>());
    });
  });
}
