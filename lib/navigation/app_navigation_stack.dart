import 'package:pragmatic_navigation/pragmatic_navigation.dart';
import 'navigation_stack_item.dart';

class AppNavigationStack extends NavigationStack<NavigationStackItem> {
  static final instance = AppNavigationStack._([
    const NavigationStackItem.artObjectList(), // initial item
  ]);

  AppNavigationStack._(List<NavigationStackItem> items) : super(items);
}
