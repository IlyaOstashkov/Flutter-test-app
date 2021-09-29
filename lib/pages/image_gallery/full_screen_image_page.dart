import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/pages/image_gallery/full_screen_image_view.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({
    required this.imageUrls,
    Key? key,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return FullScreenImageView(
      imageUrls: imageUrls,
      navigationManager: const NavigationManager(),
    );
  }
}
