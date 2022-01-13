import 'package:flutter_good_practices/data/interfaces/api_request_interface.dart';
import 'package:dio/dio.dart';

class ApiService implements IHttpInterface {
  @override
  Future<Map<String, dynamic>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params}) async {
    final response = await Dio().get(url, queryParameters: params);
    return response.data as Map<String, dynamic>;
  }
}
