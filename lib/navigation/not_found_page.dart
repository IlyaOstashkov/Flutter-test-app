import 'package:flutter/material.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

const String _title = 'Page not found';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFabric.simpleAppBar(title: _title),
      body: SafeArea(
        child: Center(
          child: Text(
            _title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
