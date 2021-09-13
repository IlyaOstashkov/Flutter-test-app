import 'package:flutter/material.dart';

class ArtObjectListItem extends StatelessWidget {
  const ArtObjectListItem({
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
        isThreeLine: true,
        dense: true,
      ),
    );
  }
}
