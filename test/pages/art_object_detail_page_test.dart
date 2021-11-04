import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'mock_bloc.dart';
import 'page_tester.dart';

class ArtObjectDetailEventFake extends Fake implements ArtObjectDetailEvent {}

class ArtObjectDetailBlocMock
    extends MockBloc<ArtObjectDetailEvent, ArtObjectDetailState>
    implements ArtObjectDetailBloc {}

void main() {
  group('ArtObjectDetailPage -', () {
    late ArtObjectDetailBlocMock artObjectDetailBloc;

    setUpAll(() {
      registerFallbackValue<ArtObjectDetailEvent>(ArtObjectDetailEventFake());
      artObjectDetailBloc = ArtObjectDetailBlocMock();
      BlocDIContainer.instance
          .map<ArtObjectDetailBloc>(() => artObjectDetailBloc);
    });

    tearDownAll(() {
      artObjectDetailBloc.close();
    });

    testWidgets('page created with initialLoading state', (widgetTester) async {
      when(() => artObjectDetailBloc.state)
          .thenReturn(const ArtObjectDetailState.initialLoading());
      await PageTester(
        child: ArtObjectDetailPage(
          artObject: ArtObjectDetailBlocTestData.artObjectPartialContent(true),
        ),
        blocs: [
          BlocProvider<ArtObjectDetailBloc>(create: (_) => artObjectDetailBloc)
        ],
      ).testPageIsCreated(tester: widgetTester);
      expect(find.byType(ArtObjectDetailView), findsOneWidget);
    });

    testWidgets('page created with partialContent state', (widgetTester) async {
      final partialContentArtObject =
          ArtObjectDetailBlocTestData.artObjectPartialContent(true);
      when(() => artObjectDetailBloc.state).thenReturn(
          ArtObjectDetailState.partialContent(partialContentArtObject));
      await PageTester(
        child: ArtObjectDetailPage(artObject: partialContentArtObject),
        blocs: [
          BlocProvider<ArtObjectDetailBloc>(create: (_) => artObjectDetailBloc)
        ],
      ).testPageIsCreated(tester: widgetTester);
      expect(find.byType(ArtObjectDetailView), findsOneWidget);
    });

    testWidgets('page created with fullContent state', (widgetTester) async {
      final fullContentArtObject =
          ArtObjectDetailBlocTestData.artObjectFullContent();
      when(() => artObjectDetailBloc.state)
          .thenReturn(ArtObjectDetailState.fullContent(fullContentArtObject));
      await PageTester(
        child: ArtObjectDetailPage(artObject: fullContentArtObject),
        blocs: [
          BlocProvider<ArtObjectDetailBloc>(create: (_) => artObjectDetailBloc)
        ],
      ).testPageIsCreated(tester: widgetTester);
      expect(find.byType(ArtObjectDetailView), findsOneWidget);
    });
  });
}
