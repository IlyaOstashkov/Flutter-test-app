import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/view/art_object_detail_view.dart';

class ArtObjectDetailPage extends StatelessWidget {
  const ArtObjectDetailPage({
    required this.artObject,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final IArtObjectRepository repository = ArtObjectRepository();
        return ArtObjectDetailBloc(repository: repository)
          ..add(ArtObjectDetailInitialEvent(artObject));
      },
      child: const ArtObjectDetailView(
        notificationManager: NotificationManager(),
        navigationManager: NavigationManager(),
      ),
    );
  }
}
