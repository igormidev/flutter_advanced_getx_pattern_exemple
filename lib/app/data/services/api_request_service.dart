import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_good_practices/app/core/exceptions/request_exeptions.dart';
import 'package:flutter_good_practices/app/data/interfaces/api_request_interface.dart';

class ApiService implements IHttpInterface {
  @override
  Future<Either<HttpRequestFailure, Map<String, dynamic>>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params}) async {
    try {
      final response = await Dio().get(url, queryParameters: params);
      final num code = response.data['code'];
      final String description = response.data['mensagem'];
      // code == 300 || code == 400 || code == 401 || code == 402 || code == 500
      if (code >= 300) {
        throw HttpRequestFailure(code, description);
      }
      return right((response.data as Map<String, dynamic>));
    } on HttpRequestFailure catch (request) {
      log('response ' + request.code.toString());
      log('mensagem ' + request.description);
      final num code = request.code;
      final String description = request.description;

      // INTEVALO 300 - 399
      if (request.code >= 300 && request.code < 400) {
        //tratamento caso seja um erro de redirecionamento
        return left(
            RedirectionHttpFailure(code: code, description: description));
        //erro caso seja um erro do lado do cliente:
        //códigos tratados: code == 400 || code == 401 || code == 402
      } else if (request.code >= 400 && request.code < 500) {
        return left(
            ClientHttpErrorFailure(code: code, description: description));
        //erro caso seja um erro do lado do servidor:
      } else if (request.code >= 500) {
        return left(
            ServerHttpErrorFailure(code: code, description: description));

        //caso seja outro código de erro não coberto
      } else {
        return left(
          UnknownHttpErrorFailure(
            code: code,
            description: 'Contacte o suporte',
          ),
        );
      }
    } on DioError catch (request) {
      // erro interno do dio
      return left(DioHttpErrorFailure(
        code: request.response?.statusCode ?? 000,
        description: 'detalhes: ${request.message}',
      ));
    } catch (e) {
      final String erro = e.toString();
      return left(UnknownHttpErrorFailure(code: 000, description: erro));
    }

    // return left(
    //   UnknownHttpErrorFailure(
    //       code: 000, description: 'Contacte o suporte'),
    // );
  }
}
