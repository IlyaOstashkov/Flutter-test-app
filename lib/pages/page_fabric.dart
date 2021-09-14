import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_view.dart';

class PageFabric {
  static Widget artObjectListPage() {
    return BlocProvider(
      create: (context) {
        final IArtObjectRepository repository = ArtObjectRepository();
        return ArtObjectListBloc(repository: repository)
          ..add(ArtObjectListFetchedEvent());
      },
      child: const ArtObjectListView(),
    );
  }
}
