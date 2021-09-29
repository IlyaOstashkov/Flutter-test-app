import 'package:flutter/material.dart';

class OffsetSpace extends StatelessWidget {
  const OffsetSpace({
    this.horizontal,
    this.vertical,
    Key? key,
  }) : super(key: key);

  const OffsetSpace.vertical([
    this.vertical = OffsetValue.medium,
    this.horizontal,
    Key? key,
  ]) : super(key: key);

  const OffsetSpace.horizontal([
    this.horizontal = OffsetValue.medium,
    this.vertical,
    Key? key,
  ]) : super(key: key);

  final OffsetValue? horizontal;
  final OffsetValue? vertical;

  @override
  Widget build(BuildContext context) {
    final double width = _size(horizontal);
    final double height = _size(vertical);
    return SizedBox(width: width, height: height);
  }

  double _size(OffsetValue? size) {
    if (size == null) {
      return 0;
    }
    switch (size) {
      case OffsetValue.verySmall:
        return 4.0;
      case OffsetValue.small:
        return 8.0;
      case OffsetValue.medium:
        return 16.0;
      case OffsetValue.big:
        return 24.0;
      case OffsetValue.veryBig:
        return 36.0;
    }
  }
}

enum OffsetValue {
  verySmall,
  small,
  medium,
  big,
  veryBig,
}
