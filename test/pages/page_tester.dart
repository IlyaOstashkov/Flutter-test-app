import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

class PageTester {
  PageTester({
    required this.child,
    this.blocs = const <BlocProvider>[],
  });

  final Widget child;
  final List<BlocProvider> blocs;

  Widget get widgetWithBlocs => MultiBlocProvider(
        providers: blocs,
        child: widget,
      );

  Widget get widget {
    return Material(
      child: MaterialApp(
        home: Navigator(
          pages: [_page()],
          onPopPage: (route, result) => false,
        ),
      ),
    );
  }

  Future<void> testPageIsCreated({required WidgetTester tester}) async {
    await tester.pumpWidget(blocs.isNotEmpty ? widgetWithBlocs : widget);
    await tester.pump();
    expect(find.byType(child.runtimeType), findsOneWidget);
  }

  MaterialPage<dynamic> _page() {
    return MaterialPage<dynamic>(
      key: ValueKey<String>(child.runtimeType.toString()),
      child: SnackBarWidget(child: child),
    );
  }
}
