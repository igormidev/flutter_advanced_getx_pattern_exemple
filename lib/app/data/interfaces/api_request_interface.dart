abstract class IHttpInterface {
  /// Faz uma requisição JSON que retorna o tipo Map.
  /// Recebe os parametros [params] da requisição e a sua [url] base.
  Future<Map<String, dynamic>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params});
}
