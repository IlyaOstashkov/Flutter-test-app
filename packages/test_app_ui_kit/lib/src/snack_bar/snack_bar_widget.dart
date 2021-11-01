import 'package:flutter/material.dart';

class SnackBarWidget extends InheritedWidget {
  const SnackBarWidget({
    required Widget child,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  void show(
    BuildContext context,
    String text,
  ) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBarWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SnackBarWidget>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
