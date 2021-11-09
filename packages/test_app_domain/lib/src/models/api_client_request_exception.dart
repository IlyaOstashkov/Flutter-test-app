class ApiClientRequestException implements Exception {
  const ApiClientRequestException({required this.cause});
  final String cause;

  @override
  String toString() {
    return cause;
  }
}
