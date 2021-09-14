import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.onTap,
    required this.child,
    this.radius = 0,
  });

  final VoidCallback? onTap;
  final Widget child;
  final double radius;

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.black12,
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: child,
    );
  }
}
