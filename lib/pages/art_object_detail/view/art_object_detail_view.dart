import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/widgets/app_bar_factory.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';

class ArtObjectDetailView extends StatefulWidget {
  const ArtObjectDetailView({
    Key? key,
    required this.notificationManager,
  }) : super(key: key);

  final INotificationManager notificationManager;

  @override
  _ArtObjectDetailView createState() => _ArtObjectDetailView();
}

class _ArtObjectDetailView extends State<ArtObjectDetailView> {
  late ArtObjectDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ArtObjectDetailBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarFabric.simpleAppBar(
        context: context,
        title: 'Art object',
      ),
      body: BlocListener<ArtObjectDetailBloc, ArtObjectDetailState>(
        listener: (context, state) {
          if (state.status == ArtObjectListStatus.failure) {
            final String message = state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Failed to fetch additional information';
            widget.notificationManager.show(
              context,
              message,
            );
          }
        },
        child: BlocBuilder<ArtObjectDetailBloc, ArtObjectDetailState>(
          builder: (context, state) {
            return const _Loader();
          },
        ),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SimpleLoader(),
        ],
      ),
    );
  }
}
