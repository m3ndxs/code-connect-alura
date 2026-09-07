class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Erro no servidor.']);
}

class OfflineException implements Exception {}
