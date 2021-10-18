import 'package:flutter/cupertino.dart';

abstract class INavigationManager {
  Future<void> push(BuildContext context, Widget page);
  Future<void> showModalPopup(BuildContext context, Widget page);
  void back(BuildContext context);
}

class NavigationManager implements INavigationManager {
  const NavigationManager();

  @override
  Future<void> push(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      CupertinoPageRoute<void>(builder: (context) => page),
    );
  }

  @override
  Future<void> showModalPopup(BuildContext context, Widget page) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => page,
    );
  }

  @override
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
