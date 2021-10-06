import 'package:flutter/material.dart';
import 'package:flutter_test_app/di_container.dart';
import 'package:flutter_test_app/pages/art_object_list/art_object_list_page.dart';

void main() {
  DIContainer.initialise();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArtObjectListPage(),
    ),
  );
}
