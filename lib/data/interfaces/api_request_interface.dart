abstract class IHttpInterface {
  Future<Map<String, dynamic>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params});
}
