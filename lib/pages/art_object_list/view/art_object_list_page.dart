import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_view.dart';

class ArtObjectListPage extends StatelessWidget {
  const ArtObjectListPage({required this.bloc, Key? key}) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Art objects')),
      body: BlocProvider(
        create: (_) => bloc,
        child: const ArtObjectListView(),
      ),
    );
  }
}
