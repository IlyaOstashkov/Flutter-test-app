import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_header.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_tile.dart';
import 'package:flutter_test_app/widgets/app_bar_fabric.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';

class ArtObjectListView extends StatefulWidget {
  const ArtObjectListView({
    required this.notificationManager,
    required this.navigationManager,
    Key? key,
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
      appBar: AppBarFabric.simpleAppBar(title: 'Art objects'),
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
              return _RefreshControl(
                onRefresh: () async {
                  _bloc.add(ArtObjectListFullReloadEvent());
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.listItems.length) return const _Loader();
                    final ArtObjectListItem item = state.listItems[index];
                    return (item.isHeader)
                        ? ArtObjectListHeader(title: item.headerTitle)
                        : ArtObjectListTile(
                            title: item.artObject?.title ?? '',
                            imageUrl: item.artObject?.imageUrl,
                            onTap: () {
                              _navigateToARtObjectDetailPage(
                                  artObject: item.artObject);
                            },
                          );
                  },
                  itemCount: _itemCount(state),
                  controller: _scrollController,
                ),
              );
            default:
              return const _Loader();
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
    final int length = state.listItems.length;
    return state.hasReachedMax ? length : length + 1;
  }

  void _navigateToARtObjectDetailPage({required ArtObject? artObject}) {
    if (artObject == null) return;
    widget.navigationManager.push(
      context,
      ArtObjectDetailPage(artObject: artObject),
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
      onRefresh: onRefresh,
      child: child,
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
      onRefresh: onRefresh,
      child: ListView(
        children: [
          const OffsetSpace.vertical(),
          Row(
            children: const [
              OffsetSpace.horizontal(),
              Flexible(
                child: SimpleText(
                  'Couldn\'t get any art objects. Please try again later',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              OffsetSpace.horizontal(),
            ],
          ),
          const OffsetSpace.vertical(),
        ],
      ),
    );
  }
}
