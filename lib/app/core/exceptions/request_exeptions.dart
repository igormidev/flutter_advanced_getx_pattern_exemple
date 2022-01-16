class HttpRequestFailure implements Exception {
  final num code;
  final String description;
  const HttpRequestFailure(this.code, this.description);
}

//HTTP error 3xx
class RedirectionHttpFailure implements HttpRequestFailure {
  @override
  final num code;
  @override
  final String description;
  RedirectionHttpFailure({required this.code, required this.description});
}

//HTTP error 4xx
class ClientHttpErrorFailure implements HttpRequestFailure {
  @override
  final num code;
  @override
  final String description;

  ClientHttpErrorFailure({required this.code, required this.description});
}

//HTTP error 5xx
class ServerHttpErrorFailure implements HttpRequestFailure {
  @override
  final num code;
  @override
  final String description;
  ServerHttpErrorFailure({required this.code, required this.description});
}

class UnknownHttpErrorFailure implements HttpRequestFailure {
  @override
  final num code;

  @override
  final String description;
  UnknownHttpErrorFailure({required this.code, required this.description});
}

class DioHttpErrorFailure implements HttpRequestFailure {
  @override
  final num code;
  @override
  final String description;

  DioHttpErrorFailure({required this.code, required this.description});
}

const String erroDesconhecido = 'Erro desconhecido ocorreu';
