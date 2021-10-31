import 'package:flutter/material.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_page.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_page.dart';

import 'package:pragmatic_navigation/pragmatic_navigation.dart';

import 'navigation_stack_item.dart';
import 'not_found_page.dart';

class NavigationRouterDelegate
    extends NavigationStackRouterDelegate<NavigationStackItem> {
  NavigationRouterDelegate(
      {required NavigationStack<NavigationStackItem> stack})
      : super(stack: stack);

  @override
  List<Page<dynamic>> pages({BuildContext? context}) => stack
      .mapItems((item, index) => item.when(
            notFound: (pathSegments) =>
                const MaterialPage<dynamic>(child: NotFoundPage()),
            artObjectList: () => const MaterialPage<dynamic>(
              key: ValueKey('ArtObjectListPage'),
              child: ArtObjectListPage(),
            ),
            artObjectDetail: (artObject) => MaterialPage<dynamic>(
              key: ValueKey('ArtObjectDetailPage_${artObject.hashCode}'),
              child: ArtObjectDetailPage(artObject: artObject),
            ),
            fullScreenImage: (imageUrls) => MaterialPage<dynamic>(
              key: ValueKey('FullScreenImagePage_${imageUrls.hashCode}'),
              child: FullScreenImagePage(imageUrls: imageUrls),
            ),
          ))
      .toList();
}
