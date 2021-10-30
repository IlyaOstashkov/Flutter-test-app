import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart' as http;
import 'package:rijks_api/rijks_api.dart' as api;
import 'package:test_app_domain/test_app_domain.dart';
import 'package:test_app_shared/test_app_shared.dart';

class DIContainer {
  static void initialise() {
    final injector = Injector();
    injector.map<NavigationManager>(
      (i) => NavigationManager(),
      isSingleton: true,
    );
    injector.map<NotificationManager>(
      (i) => NotificationManager(),
      isSingleton: true,
    );
    injector.map<http.Client>((i) => http.Client());
    injector.map<IApiClient>(
      (i) => api.RijksApiClient(httpClient: i.get<http.Client>()),
    );
    injector.map<IArtObjectRepository>(
      (i) => ArtObjectRepository(apiClient: i.get<IApiClient>()),
    );
  }
}
