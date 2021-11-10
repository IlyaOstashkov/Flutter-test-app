import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText(
    this.text, {
    this.textAlign = TextAlign.left,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),
    this.maxLines,
    Key? key,
  }) : super(key: key);

  final String? text;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis, // dots at the end
    );
  }
}
