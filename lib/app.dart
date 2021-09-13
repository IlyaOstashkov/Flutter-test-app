import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/pages_fabric.dart';

class App extends MaterialApp {
  App({Key? key})
      : super(
          key: key,
          home: PagesFabric.artObjectListPage(),
        );
}
