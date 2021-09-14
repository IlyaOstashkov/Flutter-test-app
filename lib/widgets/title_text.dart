import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    this.textAlign = TextAlign.left,
    this.isFlexible = true,
    this.maxLines,
  });

  final String text;
  final TextAlign textAlign;
  final bool isFlexible;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      text,
      isFlexible: isFlexible,
      textAlign: textAlign,
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
        color: Colors.black87,
      ),
      maxLines: maxLines,
    );
  }
}
