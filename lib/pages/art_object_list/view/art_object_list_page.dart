import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_view.dart';

class ArtObjectListPage extends StatelessWidget {
  const ArtObjectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Art objects')),
      body: Builder(
        builder: (BuildContext context) {
          return const ArtObjectListView();
        },
      ),
    );
  }
}
