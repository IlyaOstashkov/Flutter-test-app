import 'package:art_object_repository/repository/art_object_repository.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:rijks_api/rijks_api.dart' as api;

class DIContainer {
  static void initialise() {
    final Injector injector = Injector();
    injector.map<INavigationManager>(
      (i) => const NavigationManager(),
      isSingleton: true,
    );
    injector.map<INotificationManager>(
      (i) => const NotificationManager(),
      isSingleton: true,
    );
    injector.map<api.IRijksApiClient>((i) => api.RijksApiClient());
    injector.map<IArtObjectRepository>(
      (i) => ArtObjectRepository(apiClient: i.get<api.IRijksApiClient>()),
    );
  }
}
