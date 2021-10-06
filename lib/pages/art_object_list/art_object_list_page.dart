import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_view.dart';

class ArtObjectListPage extends StatelessWidget {
  const ArtObjectListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Injector injector = Injector();
    return BlocProvider(
      create: (context) {
        return ArtObjectListBloc(
            repository: injector.get<IArtObjectRepository>())
          ..add(ArtObjectListFetchedEvent());
      },
      child: ArtObjectListView(
        notificationManager: injector.get<INotificationManager>(),
        navigationManager: injector.get<INavigationManager>(),
      ),
    );
  }
}
