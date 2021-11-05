import 'package:flutter/material.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

class MaterialAppAppWidget extends StatelessWidget {
  const MaterialAppAppWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: key,
      home: Material(
        child: Navigator(
          pages: [
            MaterialPage<dynamic>(
              key: ValueKey<String>(child.runtimeType.toString()),
              child: SnackBarWidget(child: child),
            ),
          ],
          onPopPage: (route, result) => false,
        ),
      ),
    );
  }
}
