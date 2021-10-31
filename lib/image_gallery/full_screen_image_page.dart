import 'package:flutter/material.dart';

import 'full_screen_image_view.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({
    required this.imageUrls,
    Key? key,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return FullScreenImageView(imageUrls: imageUrls);
  }
}
