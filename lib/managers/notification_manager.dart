import 'package:flutter/material.dart';

abstract class INotificationManager {
  void show(
    BuildContext context,
    String text,
  );
}

class NotificationManager implements INotificationManager {
  const NotificationManager();

  void show(
    BuildContext context,
    String text,
  ) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
