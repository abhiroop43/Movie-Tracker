class ServerException implements Exception {
  final String message;

  ServerException({this.message = "Error while calling API"});
}
