import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';
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

    GoldenRunner.executePage(
        widgetType: ArtObjectDetailPage,
        setupFunction: () {
          when(() => artObjectDetailBloc.state)
              .thenReturn(const ArtObjectDetailState.initialLoading());
        },
        scenario: GoldenRunnerScenario(
          name: 'initial loading state',
          child: PageTester(
            child: ArtObjectDetailPage(
              artObject:
                  ArtObjectDetailBlocTestData.artObjectPartialContent(true),
            ),
            blocs: [
              BlocProvider<ArtObjectDetailBloc>(
                  create: (_) => artObjectDetailBloc)
            ],
          ).pageWidget,
        ),
        test: (tester) async {
          expect(find.byType(ArtObjectDetailView), findsOneWidget);
        });

    GoldenRunner.executePage(
        widgetType: ArtObjectDetailPage,
        setupFunction: () {
          final partialContentArtObject =
              ArtObjectDetailBlocTestData.artObjectPartialContent(true);
          when(() => artObjectDetailBloc.state).thenReturn(
              ArtObjectDetailState.partialContent(partialContentArtObject));
        },
        scenario: GoldenRunnerScenario(
          name: 'partial content state',
          child: PageTester(
            child: ArtObjectDetailPage(
              artObject:
                  ArtObjectDetailBlocTestData.artObjectPartialContent(true),
            ),
            blocs: [
              BlocProvider<ArtObjectDetailBloc>(
                  create: (_) => artObjectDetailBloc)
            ],
          ).pageWidget,
        ),
        test: (tester) async {
          expect(find.byType(ArtObjectDetailView), findsOneWidget);
        });

    GoldenRunner.executePage(
        widgetType: ArtObjectDetailPage,
        setupFunction: () {
          when(() => artObjectDetailBloc.state).thenReturn(
              ArtObjectDetailState.fullContent(
                  ArtObjectDetailBlocTestData.artObjectFullContent()));
        },
        scenario: GoldenRunnerScenario(
          name: 'full content state',
          child: PageTester(
            child: ArtObjectDetailPage(
                artObject: ArtObjectDetailBlocTestData.artObjectFullContent()),
            blocs: [
              BlocProvider<ArtObjectDetailBloc>(
                  create: (_) => artObjectDetailBloc)
            ],
          ).pageWidget,
        ),
        test: (tester) async {
          expect(find.byType(ArtObjectDetailView), findsOneWidget);
        });
  });
}
