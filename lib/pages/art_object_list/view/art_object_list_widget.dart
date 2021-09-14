import 'package:flutter/material.dart';

class ArtObjectListWidget extends StatelessWidget {
  const ArtObjectListWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(title),
        subtitle: Text(title),
        isThreeLine: true,
        dense: true,
      ),
    );
  }
}
