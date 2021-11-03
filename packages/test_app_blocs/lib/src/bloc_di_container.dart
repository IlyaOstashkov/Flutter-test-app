import 'package:http/http.dart' as http;
import 'package:rijks_api/rijks_api.dart' as api;
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart';
import 'package:test_app_shared/test_app_shared.dart';

class BlocDIContainer extends DIContainer {
  static final instance = BlocDIContainer();

  void initialise() {
    _registerApiClient();
    _registerRepositories();
    map<ArtObjectDetailBloc>(
      () => ArtObjectDetailBloc(repository: get<IArtObjectRepository>()),
    );
    map<ArtObjectListBloc>(
      () => ArtObjectListBloc(repository: get<IArtObjectRepository>()),
    );
  }

  void _registerApiClient() {
    // ignore: unnecessary_lambdas
    map<http.Client>(() => http.Client());
    map<IApiClient>(() => api.RijksApiClient(httpClient: get<http.Client>()));
  }

  void _registerRepositories() {
    map<IArtObjectRepository>(
        () => ArtObjectRepository(apiClient: get<IApiClient>()));
  }
}
