import 'package:flutter/cupertino.dart';

class NavigationManager {
  Future<void> push(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      CupertinoPageRoute<void>(builder: (context) => page),
    );
  }

  Future<void> showModalPopup(BuildContext context, Widget page) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => page,
    );
  }

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
