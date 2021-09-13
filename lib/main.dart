import 'app.dart';
import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'pages/art_object_list/bloc/art_object_list_event.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        final IArtObjectRepository repository = ArtObjectRepository();
        final ArtObjectListBloc bloc = ArtObjectListBloc(repository: repository)
          ..add(ArtObjectListFetchedEvent());
        return bloc;
      },
      child: App(),
    ),
  );
}
