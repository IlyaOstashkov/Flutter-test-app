import 'package:flutter/material.dart';

class AppBarFabric {
  static PreferredSizeWidget simpleAppBar({
    required BuildContext context,
    String? title,
  }) {
    return AppBar(
      title: Text(
        title ?? '',
        style: const TextStyle(color: Colors.black87),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }
}
