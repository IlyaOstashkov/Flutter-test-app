import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart';
import 'package:test_app_shared/test_app_shared.dart';

import 'art_object_list_view.dart';

class ArtObjectListPage extends StatelessWidget {
  const ArtObjectListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final injector = Injector();
    return BlocProvider(
      create: (context) {
        return ArtObjectListBloc(
            repository: injector.get<IArtObjectRepository>())
          ..add(const ArtObjectListEvent.fetched());
      },
      child: ArtObjectListView(
        notificationManager: injector.get<NotificationManager>(),
      ),
    );
  }
}
