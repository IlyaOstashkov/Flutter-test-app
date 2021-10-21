import 'package:flutter/material.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

class ArtObjectListHeader extends StatelessWidget {
  const ArtObjectListHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TitleText(
        title,
        maxLines: 2,
      ),
    );
  }
}
