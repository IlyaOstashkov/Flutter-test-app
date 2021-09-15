import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/title_text.dart';

class ArtObjectListHeader extends StatelessWidget {
  const ArtObjectListHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TitleText(
        title,
        isFlexible: false,
        maxLines: 2,
      ),
    );
  }
}