import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/loadable_image.dart';

class CircleLoadableImage extends StatelessWidget {
  const CircleLoadableImage({
    required this.radius,
    required this.imageUrl,
    required this.placeholder,
    this.borderWidth = 0,
    this.onTap,
  });

  final double radius;
  final String? imageUrl;
  final Widget placeholder;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          color: Colors.black12,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl == null) {
      return placeholder;
    }
    return LoadableImage(
      imageUrl: imageUrl!,
      onTap: onTap,
    );
  }
}