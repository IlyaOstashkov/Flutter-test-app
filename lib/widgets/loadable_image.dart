import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/transparent_button.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class LoadableImage extends StatelessWidget {
  const LoadableImage({
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TransparentButton(
      onTap: onTap,
      child: OptimizedCacheImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SimpleLoader(),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }
}
