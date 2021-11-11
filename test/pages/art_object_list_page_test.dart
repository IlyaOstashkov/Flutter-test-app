import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_header.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_page.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_tile.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
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

    testWidgets('page created with initialLoading state', (widgetTester) async {
      when(() => artObjectListBloc.state)
          .thenReturn(const ArtObjectListState.initialLoading());
      await PageTester(
        child: const ArtObjectListPage(),
        blocs: [
          BlocProvider<ArtObjectListBloc>(create: (_) => artObjectListBloc)
        ],
      ).pumpAndFindPage(tester: widgetTester);
      expect(find.byType(ArtObjectListView), findsOneWidget);
      expect(find.byType(ArtObjectListHeader), findsNothing);
      expect(find.byType(ArtObjectListTile), findsNothing);
    });

    testWidgets('page created with header and 2 items', (widgetTester) async {
      when(() => artObjectListBloc.state).thenReturn(
          ArtObjectListBlocTestData.contentStateWithHeaderAnd2Items());
      await PageTester(
        child: const ArtObjectListPage(),
        blocs: [
          BlocProvider<ArtObjectListBloc>(create: (_) => artObjectListBloc)
        ],
      ).pumpAndFindPage(tester: widgetTester);
      expect(find.byType(ArtObjectListView), findsOneWidget);
      expect(find.byType(ArtObjectListHeader), findsOneWidget);
      expect(find.byType(ArtObjectListTile), findsNWidgets(2));
    });
  });
}
