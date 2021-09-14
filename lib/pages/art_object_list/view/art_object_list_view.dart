import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_header.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_tile.dart';
import 'package:flutter_test_app/widgets/app_bar_factory.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';

class ArtObjectListView extends StatefulWidget {
  const ArtObjectListView({
    Key? key,
    required this.notificationManager,
  }) : super(key: key);

  final INotificationManager notificationManager;

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
      backgroundColor: Colors.white,
      appBar: AppBarFabric.simpleAppBar(
        context: context,
        title: 'Art objects',
      ),
      body: BlocListener<ArtObjectListBloc, ArtObjectListState>(
        listener: (context, state) {
          if (state.status == ArtObjectListStatus.failure) {
            final String message = state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Failed to fetch art objects';
            widget.notificationManager.show(
              context,
              message,
            );
          }
        },
        child: BlocBuilder<ArtObjectListBloc, ArtObjectListState>(
          builder: (context, state) {
            switch (state.status) {
              case ArtObjectListStatus.failure:
              case ArtObjectListStatus.success:
                if (state.listItems.isEmpty) {
                  return const _NoArtObjectsPlaceholderWidget();
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.listItems.length
                        ? _Loader()
                        : _buildListItem(state.listItems[index], index);
                  },
                  itemCount: _itemCount(state),
                  controller: _scrollController,
                );
              default:
                return _Loader();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _itemCount(ArtObjectListState state) {
    final int length = state.listItems.length;
    return state.hasReachedMax ? length : length + 1;
  }

  Widget _buildListItem(
    ArtObjectListItem listItem,
    int index,
  ) {
    if (listItem.isHeader) {
      return ArtObjectListHeader(title: listItem.headerTitle);
    }
    final ArtObject? artObject = listItem.artObject;
    String title = '';
    if (artObject != null) {
      title = index.toString() + ' - ' + artObject.title;
    }
    return ArtObjectListTile(
      title: title,
      imageUrl: listItem.artObject?.imageUrl,
      onTap: () {
        // TODO: navigation
      },
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

class _NoArtObjectsPlaceholderWidget extends StatelessWidget {
  const _NoArtObjectsPlaceholderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          const OffsetSpace.horizontal(),
          SimpleText(
            'Couldn\'t get any art objects. Please try again later',
            maxLines: 3,
            isFlexible: true,
            textAlign: TextAlign.center,
          ),
          const OffsetSpace.horizontal(),
        ],
      ),
    );
  }
}
