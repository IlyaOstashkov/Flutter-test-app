import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/circle_loadable_image.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';
import 'package:flutter_test_app/widgets/transparent_button.dart';

class ArtObjectListTile extends StatelessWidget {
  const ArtObjectListTile({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final VoidCallback onTap;

  static const double _containerRadius = 20.0;
  static const double _imageRadius = 40.0;
  static const double _containerPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _containerPadding,
        right: _containerPadding,
        top: 0,
        bottom: _containerPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.03),
          borderRadius: BorderRadius.circular(_containerRadius),
        ),
        child: TransparentButton(
          onTap: onTap,
          radius: _containerRadius,
          child: Column(
            children: [
              const OffsetSpace.vertical(),
              Row(
                children: <Widget>[
                  const OffsetSpace.horizontal(),
                  _Image(
                    imageRadius: _imageRadius,
                    imageUrl: imageUrl,
                  ),
                  const OffsetSpace.horizontal(),
                  _TitleText(title: title),
                  const OffsetSpace.horizontal(),
                ],
              ),
              const OffsetSpace.vertical(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.imageRadius,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final double imageRadius;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleLoadableImage(
      borderWidth: 1.0,
      radius: imageRadius,
      imageUrl: imageUrl,
      placeholder: const Icon(
        Icons.color_lens,
        color: Colors.black12,
        size: 50.0,
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SimpleText(
        title,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(fontSize: 16.0),
        maxLines: 3,
      ),
    );
  }
}
