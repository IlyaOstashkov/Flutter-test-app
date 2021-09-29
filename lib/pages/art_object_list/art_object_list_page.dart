import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) {
        final IArtObjectRepository repository = ArtObjectRepository();
        return ArtObjectListBloc(repository: repository)
          ..add(ArtObjectListFetchedEvent());
      },
      child: const ArtObjectListView(
        notificationManager: NotificationManager(),
        navigationManager: NavigationManager(),
      ),
    );
  }
}
