import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_header.dart';
import 'package:flutter_test_app/pages/art_object_list/view/art_object_list_tile.dart';
import 'package:flutter_test_app/pages/art_object_list/view_models/art_object_list_view_model.dart';
import 'package:flutter_test_app/widgets/app_bar_fabric.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';
import 'package:test_app_domain/test_app_domain.dart';

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
          state.maybeWhen(
              error: (errorMessage) {
                final message = errorMessage.isNotEmpty
                    ? errorMessage
                    : 'Failed to fetch art objects';
                widget.notificationManager.show(
                  context,
                  message,
                );
              },
              orElse: () {});
        },
        builder: (context, state) {
          return state.when(initialLoading: () {
            return const _Loader();
          }, content: (listItems, reachedMax, century, fetchPage) {
            if (listItems.isEmpty) {
              return _NoArtObjectsPlaceholderWidget(onRefresh: () async {
                _bloc.add(const ArtObjectListEvent.fullReload());
              });
            }
            return _List(
                listItems: listItems,
                reachedMax: reachedMax,
                onRefresh: () async {
                  _bloc.add(const ArtObjectListEvent.fullReload());
                },
                onItemTap: (artObject) async {
                  _navigateToARtObjectDetailPage(artObject: artObject);
                },
                scrollController: _scrollController);
          }, error: (errorMessage) {
            return _NoArtObjectsPlaceholderWidget(onRefresh: () async {
              _bloc.add(const ArtObjectListEvent.fullReload());
            });
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToARtObjectDetailPage({required ArtObject? artObject}) {
    if (artObject == null) return;
    widget.navigationManager.push(
      context,
      ArtObjectDetailPage(artObject: artObject),
    );
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(const ArtObjectListEvent.fetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.listItems,
    required this.reachedMax,
    required this.onRefresh,
    required this.onItemTap,
    required this.scrollController,
  });

  final List<ArtObjectListViewModel> listItems;
  final bool reachedMax;
  final RefreshCallback onRefresh;
  final Future<void> Function(ArtObject?) onItemTap;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return _RefreshControl(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index >= listItems.length) return const _Loader();
          final item = listItems[index];
          return (item.isHeader)
              ? ArtObjectListHeader(title: item.headerTitle)
              : ArtObjectListTile(
                  title: item.artObject?.title ?? '',
                  imageUrl: item.artObject?.imageUrl,
                  onTap: () => onItemTap(item.artObject),
                );
        },
        itemCount: reachedMax ? listItems.length : listItems.length + 1,
        controller: scrollController,
      ),
    );
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
                  "Couldn't get any art objects. Please try again later",
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
