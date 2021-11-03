import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart';

import 'art_object_detail_view.dart';

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
        return BlocDIContainer.instance.get<ArtObjectDetailBloc>()
          ..add(ArtObjectDetailEvent.initialLoad(artObject));
      },
      child: const ArtObjectDetailView(),
    );
  }
}
