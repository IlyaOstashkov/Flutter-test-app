import 'package:flutter/material.dart';
import 'pages/art_object_list/view/art_object_list_page.dart';

class App extends MaterialApp {
  const App({Key? key})
      : super(
          key: key,
          home: const ArtObjectListPage(),
        );
}
