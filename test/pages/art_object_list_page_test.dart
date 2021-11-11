import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_header.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_page.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_tile.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';
import 'mock_bloc.dart';
import 'page_tester.dart';

class ArtObjectListEventFake extends Fake implements ArtObjectListEvent {}

class ArtObjectListBlocMock
    extends MockBloc<ArtObjectListEvent, ArtObjectListState>
    implements ArtObjectListBloc {}

void main() {
  group('ArtObjectListPage -', () {
    late ArtObjectListBloc artObjectListBloc;

    setUpAll(() {
      registerFallbackValue<ArtObjectListEvent>(ArtObjectListEventFake());
      artObjectListBloc = ArtObjectListBlocMock();
      BlocDIContainer.instance.map<ArtObjectListBloc>(() => artObjectListBloc);
    });

    tearDownAll(() {
      artObjectListBloc.close();
    });

    GoldenRunner.executePage(
        widgetType: ArtObjectListPage,
        setupFunction: () {
          when(() => artObjectListBloc.state)
              .thenReturn(const ArtObjectListState.initialLoading());
        },
        scenario: GoldenRunnerScenario(
          name: 'initial loading state',
          child: PageTester(
            child: const ArtObjectListPage(),
            blocs: [
              BlocProvider<ArtObjectListBloc>(create: (_) => artObjectListBloc)
            ],
          ).pageWidget,
        ),
        test: (tester) async {
          expect(find.byType(ArtObjectListView), findsOneWidget);
          expect(find.byType(ArtObjectListHeader), findsNothing);
          expect(find.byType(ArtObjectListTile), findsNothing);
        });

    GoldenRunner.executePage(
        widgetType: ArtObjectListPage,
        setupFunction: () {
          when(() => artObjectListBloc.state).thenReturn(
              ArtObjectListBlocTestData.contentStateWithHeaderAnd2Items());
        },
        scenario: GoldenRunnerScenario(
          name: 'header and 2 items',
          child: PageTester(
            child: const ArtObjectListPage(),
            blocs: [
              BlocProvider<ArtObjectListBloc>(create: (_) => artObjectListBloc)
            ],
          ).pageWidget,
        ),
        test: (tester) async {
          expect(find.byType(ArtObjectListView), findsOneWidget);
          expect(find.byType(ArtObjectListHeader), findsOneWidget);
          expect(find.byType(ArtObjectListTile), findsNWidgets(2));
        });
  });
}
