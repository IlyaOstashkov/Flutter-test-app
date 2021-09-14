import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/transparent_button.dart';

class LoadableImage extends StatelessWidget {
  const LoadableImage({
    required this.imageUrl,
    required this.onTap,
  });

  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TransparentButton(
      onTap: onTap,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => SimpleLoader(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
