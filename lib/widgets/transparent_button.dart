import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.black12,
      onTap: onTap,
      child: child,
    );
  }
}
