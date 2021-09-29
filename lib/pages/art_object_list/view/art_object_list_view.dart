import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_header.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_tile.dart';
import 'package:flutter_test_app/pages/page_fabric.dart';
import 'package:flutter_test_app/widgets/app_bar_factory.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';

class ArtObjectListView extends StatefulWidget {
  const ArtObjectListView({
    Key? key,
    required this.notificationManager,
    required this.navigationManager,
  }) : super(key: key);

  final INotificationManager notificationManager;
  final INavigationManager navigationManager;

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
      body: BlocConsumer<ArtObjectListBloc, ArtObjectListState>(
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
        builder: (context, state) {
          switch (state.status) {
            case ArtObjectListStatus.failure:
            case ArtObjectListStatus.success:
              if (state.listItems.isEmpty) {
                return _NoArtObjectsPlaceholderWidget(onRefresh: () async {
                  _bloc.add(ArtObjectListFullReloadEvent());
                });
              }
              return _buildListView(state);
            default:
              return const _Loader();
          }
        },
      ),
    );
  }

  Widget _buildListView(ArtObjectListState state) {
    return _RefreshControl(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= state.listItems.length
              ? const _Loader()
              : _buildListItem(state.listItems[index]);
        },
        itemCount: _itemCount(state),
        controller: _scrollController,
      ),
      onRefresh: () async {
        _bloc.add(ArtObjectListFullReloadEvent());
      },
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

  Widget _buildListItem(ArtObjectListItem listItem) {
    if (listItem.isHeader) {
      return ArtObjectListHeader(title: listItem.headerTitle);
    }
    final ArtObject? artObject = listItem.artObject;
    final String title = artObject != null ? artObject.title : '';
    return ArtObjectListTile(
      title: title,
      imageUrl: listItem.artObject?.imageUrl,
      onTap: () {
        _navigateToARtObjectDetailPage(artObject: artObject);
      },
    );
  }

  void _navigateToARtObjectDetailPage({required ArtObject? artObject}) {
    if (artObject == null) return;
    widget.navigationManager.push(
      context,
      PageFabric.artObjectDetailPage(artObject: artObject),
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

class _RefreshControl extends StatelessWidget {
  const _RefreshControl({
    required this.child,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black12,
      child: child,
      onRefresh: onRefresh,
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
        children: const [SimpleLoader()],
      ),
    );
  }
}

class _NoArtObjectsPlaceholderWidget extends StatelessWidget {
  const _NoArtObjectsPlaceholderWidget({
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return _RefreshControl(
      child: ListView(
        children: [
          const OffsetSpace.vertical(),
          Row(
            children: const [
              OffsetSpace.horizontal(),
              SimpleText(
                'Couldn\'t get any art objects. Please try again later',
                maxLines: 3,
                isFlexible: true,
                textAlign: TextAlign.center,
              ),
              OffsetSpace.horizontal(),
            ],
          ),
          const OffsetSpace.vertical(),
        ],
      ),
      onRefresh: onRefresh,
    );
  }
}
