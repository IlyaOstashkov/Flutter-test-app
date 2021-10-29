import 'dart:async';
import '../interfaces/api_client_interface.dart';
import '../models/art_object.dart';

abstract class IArtObjectRepository {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}

class ArtObjectRepository implements IArtObjectRepository {
  ArtObjectRepository({required IApiClient apiClient}) : _apiClient = apiClient;

  final IApiClient _apiClient;

  @override
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  }) {
    // NOTE: here we can also use data base
    return _apiClient.getArtObjectList(
      page: page,
      limit: limit,
      century: century,
    );
  }

  @override
  Future<ArtObject> getArtObject({required String objectNumber}) {
    // NOTE: here we can also use data base
    return _apiClient.getArtObject(objectNumber: objectNumber);
  }
}
