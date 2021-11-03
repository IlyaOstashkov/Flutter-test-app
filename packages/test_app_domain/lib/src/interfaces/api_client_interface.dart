import '../models/art_object.dart';

class ApiClientRequestException implements Exception {
  const ApiClientRequestException({required this.cause});
  final String cause;

  @override
  String toString() {
    return cause;
  }
}

abstract class IApiClient {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}
