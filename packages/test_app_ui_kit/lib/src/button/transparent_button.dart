import 'package:flutter/material.dart';

// some comment

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.onTap,
    required this.child,
    this.radius = 0,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.black12,
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
