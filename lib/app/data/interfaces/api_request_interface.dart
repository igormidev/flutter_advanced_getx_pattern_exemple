import 'package:dartz/dartz.dart';
import 'package:flutter_good_practices/app/core/exceptions/request_exeptions.dart';

abstract class IHttpInterface {
  /// Faz uma requisição JSON que retorna o tipo Map.
  /// Recebe os parametros [params] da requisição e a sua [url] base.
  Future<Either<HttpRequestFailure, Map<String, dynamic>>> makeJsonRequest(
      {required String url, Map<String, dynamic>? params});

  //Either<RequestFailure, Map<String, dynamic>>
}
