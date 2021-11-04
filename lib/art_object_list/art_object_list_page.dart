import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_blocs/test_app_blocs.dart';

import 'art_object_list_view.dart';

class ArtObjectListPage extends StatelessWidget {
  const ArtObjectListPage({
    Key? key,
  }) : super(key: key);

  final _flag = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BlocDIContainer.instance.get<ArtObjectListBloc>()
          ..add(const ArtObjectListEvent.fetched());
      },
      child: const ArtObjectListView(),
    );
  }
}
