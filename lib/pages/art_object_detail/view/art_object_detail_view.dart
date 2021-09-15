import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/page_fabric.dart';
import 'package:flutter_test_app/widgets/app_bar_factory.dart';
import 'package:flutter_test_app/widgets/circle_loadable_image.dart';
import 'package:flutter_test_app/widgets/offset_space.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';
import 'package:flutter_test_app/widgets/transparent_button.dart';

class ArtObjectDetailView extends StatefulWidget {
  const ArtObjectDetailView({
    Key? key,
    required this.notificationManager,
    required this.navigationManager,
  }) : super(key: key);

  final INotificationManager notificationManager;
  final INavigationManager navigationManager;

  @override
  _ArtObjectDetailView createState() => _ArtObjectDetailView();
}

class _ArtObjectDetailView extends State<ArtObjectDetailView> {
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
            return ListView(
              children: [
                OffsetSpace.vertical(OffsetValue.big),
                state.artObject != null
                    ? _TopViews(
                        artObject: state.artObject!,
                        onImageTap: () {
                          if ((state.artObject!.imageUrl ?? '').isEmpty) {
                            return;
                          }
                          final Widget page =
                              PageFabric.imageGalleryPage(imageUrls: [
                            state.artObject!.imageUrl!,
                          ]);
                          widget.navigationManager.push(context, page);
                        })
                    : Container(),
                state.status == ArtObjectDetailStatus.success &&
                        state.artObject != null
                    ? _AdditionalViews(artObject: state.artObject!)
                    : Container(),
                state.status == ArtObjectDetailStatus.initialLoading
                    ? _Loader()
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AdditionalViews extends StatelessWidget {
  const _AdditionalViews({
    required this.artObject,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OffsetSpace.vertical(),
        ...(artObject.description ?? '').isNotEmpty
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OffsetSpace.horizontal(),
                    _RegularText(text: artObject.description!),
                    OffsetSpace.horizontal(),
                  ],
                ),
                OffsetSpace.vertical(),
              ]
            : [Container()],
        ...(artObject.principalOrFirstMaker ?? '').isNotEmpty
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OffsetSpace.horizontal(),
                    _GreyText(text: artObject.principalOrFirstMaker!),
                    OffsetSpace.horizontal(),
                  ],
                ),
                OffsetSpace.vertical(),
              ]
            : [Container()],
        ...(artObject.presentingDate ?? '').isNotEmpty
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OffsetSpace.horizontal(),
                    _RegularText(text: artObject.presentingDate!),
                    OffsetSpace.horizontal(),
                  ],
                ),
                OffsetSpace.vertical(),
              ]
            : [Container()],
      ],
    );
  }
}

class _RegularText extends StatelessWidget {
  const _RegularText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      text,
      textAlign: TextAlign.center,
      textStyle: TextStyle(
        fontSize: 14.0,
      ),
      maxLines: 50,
      isFlexible: true,
    );
  }
}

class _TopViews extends StatelessWidget {
  const _TopViews({
    required this.artObject,
    required this.onImageTap,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TransparentButton(
              onTap: onImageTap,
              child: _Image(
                imageRadius: 100.0,
                imageUrl: artObject.imageUrl,
              ),
            ),
          ],
        ),
        OffsetSpace.vertical(OffsetValue.big),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OffsetSpace.horizontal(),
            _Title(title: artObject.title),
            OffsetSpace.horizontal(),
          ],
        ),
        OffsetSpace.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OffsetSpace.horizontal(),
            _GreyText(text: artObject.objectNumber),
            OffsetSpace.horizontal(),
          ],
        ),
      ],
    );
  }
}

class _GreyText extends StatelessWidget {
  const _GreyText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      text,
      textAlign: TextAlign.center,
      textStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.black38,
      ),
      maxLines: 2,
      isFlexible: true,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      title,
      textAlign: TextAlign.center,
      textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 5,
      isFlexible: true,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.imageRadius,
    required this.imageUrl,
  }) : super(key: key);

  final double imageRadius;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleLoadableImage(
      borderWidth: 2.0,
      radius: imageRadius,
      imageUrl: imageUrl,
      placeholder: Icon(
        Icons.color_lens,
        color: Colors.black12,
        size: 100.0,
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
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SimpleLoader()],
      ),
    );
  }
}
