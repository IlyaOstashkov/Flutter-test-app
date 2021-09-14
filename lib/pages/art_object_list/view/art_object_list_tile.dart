import 'package:flutter/material.dart';

class ArtObjectListTile extends StatelessWidget {
  const ArtObjectListTile({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(title),
      isThreeLine: true,
      dense: true,
    );
  }
}
