import 'package:art_object_repository/repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_page.dart';

class PagesFabric {
  static Widget artObjectListPage() {
    final IArtObjectRepository repository = ArtObjectRepository();
    final ArtObjectListBloc bloc = ArtObjectListBloc(repository: repository)
      ..add(ArtObjectListFetchedEvent());
    return ArtObjectListPage(bloc: bloc);
  }
}
