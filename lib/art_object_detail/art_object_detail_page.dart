import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart';
import 'package:test_app_shared/test_app_shared.dart';

import 'art_object_detail_view.dart';

class ArtObjectDetailPage extends StatelessWidget {
  const ArtObjectDetailPage({
    required this.artObject,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) {
    final injector = Injector();
    return BlocProvider(
      create: (context) {
        return ArtObjectDetailBloc(
          repository: injector.get<IArtObjectRepository>(),
          artObject: artObject,
        )..add(ArtObjectDetailEvent.fetchFullContent(artObject.objectNumber));
      },
      child: ArtObjectDetailView(
        notificationManager: injector.get<NotificationManager>(),
        navigationManager: injector.get<NavigationManager>(),
      ),
    );
  }
}
