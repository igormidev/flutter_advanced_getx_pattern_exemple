import 'package:dartz/dartz.dart';
import 'package:flutter_good_practices/app/core/exceptions/request_exeptions.dart';
import 'package:flutter_good_practices/app/data/providers/consultar_pedagios_provider.dart';
import 'package:flutter_good_practices/app/data/providers/localization_provider.dart';

class TragetoriaRepository {
  ConsultarPedagioProvider pedagioProvider;
  LocalizationProvider localizationProvider;
  TragetoriaRepository(
      {required this.pedagioProvider, required this.localizationProvider});

  Future<Map<String, double>> pegarLatitudeLongitude() async {
    final localization = await localizationProvider.getLocal();
    return localization;
  }

  Future<Either<HttpRequestFailure, Map<String, dynamic>>> calcularTragetoria(
    String cepOrigem,
    String cepDestilo,
    double consumoPorLitroCarro,
    double precoCombustivel, {
    String eixos = '2',
    String veiculo = 'carro',
    bool paradas = true,
  }) async {
    final pedagio = await pedagioProvider.calcularTragetoria(
        cepOrigem, cepDestilo, consumoPorLitroCarro, precoCombustivel);
    return pedagio;
  }
}
