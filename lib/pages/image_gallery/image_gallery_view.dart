import 'package:flutter/material.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/widgets/simple_loader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGalleryPage extends StatelessWidget {
  ImageGalleryPage({
    required this.imageUrls,
    required this.navigationManager,
  });

  final List<String> imageUrls;
  final INavigationManager navigationManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Colors.black,
            child: PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(color: Colors.black),
              itemCount: imageUrls.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrls[index]),
                  initialScale: PhotoViewComputedScale.contained * 1,
                );
              },
              loadingBuilder: (context, event) => Center(
                child: SimpleLoader(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigationManager.back(context),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
