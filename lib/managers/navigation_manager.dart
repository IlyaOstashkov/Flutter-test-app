import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class INavigationManager {
  Future<void> push(BuildContext context, Widget page);
  Future<void> showModalPopup(BuildContext context, Widget page);
  void back(BuildContext context);
}

class NavigationManager implements INavigationManager {
  const NavigationManager();

  Future<void> push(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  Future<void> showModalPopup(BuildContext context, Widget page) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => page,
    );
  }

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
