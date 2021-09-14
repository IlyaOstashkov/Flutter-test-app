import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/circle_loadable_image.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';
import 'package:flutter_test_app/widgets/transparent_button.dart';

class ArtObjectListTile extends StatelessWidget {
  const ArtObjectListTile({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
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
              OffsetSpace.vertical(),
              Row(
                children: <Widget>[
                  OffsetSpace.horizontal(),
                  _Image(
                    imageRadius: _imageRadius,
                    imageUrl: imageUrl,
                  ),
                  OffsetSpace.horizontal(),
                  _TitleText(title: title),
                  OffsetSpace.horizontal(),
                ],
              ),
              OffsetSpace.vertical(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required double imageRadius,
    required this.imageUrl,
  })  : _imageRadius = imageRadius,
        super(key: key);

  final double _imageRadius;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleLoadableImage(
      borderWidth: 1.0,
      radius: _imageRadius,
      imageUrl: imageUrl,
      placeholder: Icon(
        Icons.color_lens,
        color: Colors.black12,
        size: 50.0,
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      title,
      textAlign: TextAlign.left,
      textStyle: TextStyle(
        fontSize: 16.0,
      ),
      maxLines: 3,
      isFlexible: true,
    );
  }
}
