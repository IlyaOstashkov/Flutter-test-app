import 'package:flutter/material.dart';

class AppBarFabric {
  static PreferredSizeWidget simpleAppBar({
    required BuildContext context,
    String? title,
  }) {
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(color: Colors.black87),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      backgroundColor: Colors.white,
    );
  }
}
