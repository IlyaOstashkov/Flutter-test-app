import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_item.dart';

class ArtObjectListView extends StatefulWidget {
  const ArtObjectListView({Key? key}) : super(key: key);

  @override
  _ArtObjectListView createState() => _ArtObjectListView();
}

class _ArtObjectListView extends State<ArtObjectListView> {
  final _scrollController = ScrollController();
  late ArtObjectListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = context.read<ArtObjectListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Art objects')),
      body: BlocBuilder<ArtObjectListBloc, ArtObjectListState>(
        builder: (context, state) {
          switch (state.status) {
            case ArtObjectListStatus.failure:
              return _ErrorPlaceholderWidget(errorMessage: state.errorMessage);
            case ArtObjectListStatus.success:
              if (state.artObjects.isEmpty) {
                return const _NoArtObjectsPlaceholderWidget();
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.artObjects.length
                      ? const _CenterLoader()
                      : _buildListItem(state.artObjects[index]);
                },
                itemCount: _itemCount(state),
                controller: _scrollController,
              );
            default:
              return const _CenterLoader();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _itemCount(ArtObjectListState state) {
    return state.hasReachedMax
        ? state.artObjects.length
        : state.artObjects.length + 1;
  }

  Widget _buildListItem(ArtObject artObject) {
    return ArtObjectListItem(
      title: artObject.title,
      imageUrl: artObject.imageUrl,
    );
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(ArtObjectListFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _CenterLoader extends StatelessWidget {
  const _CenterLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorPlaceholderWidget extends StatelessWidget {
  const _ErrorPlaceholderWidget({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage.isNotEmpty ? errorMessage : 'Failed to fetch art objects',
      ),
    );
  }
}

class _NoArtObjectsPlaceholderWidget extends StatelessWidget {
  const _NoArtObjectsPlaceholderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No posts'),
    );
  }
}
