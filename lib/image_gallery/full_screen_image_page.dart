import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:test_app_shared/test_app_shared.dart';

import 'full_screen_image_view.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({
    required this.imageUrls,
    Key? key,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final injector = Injector();
    return FullScreenImageView(
      imageUrls: imageUrls,
      navigationManager: injector.get<NavigationManager>(),
    );
  }
}
