import 'package:dio/dio.dart';
import 'package:flutter_good_practices/app/data/interfaces/api_request_interface.dart';

class ApiService implements IHttpInterface {
  @override
  Future<Map<String, dynamic>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params}) async {
    final response = await Dio().get(url, queryParameters: params);
    return response.data as Map<String, dynamic>;
  }
}
