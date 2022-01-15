import 'package:flutter_good_practices/app/data/providers/consultar_pedagios_provider.dart';
import 'package:flutter_good_practices/app/data/services/localization_service.dart';

class TragetoriaRepository {
  ConsultarPedagioProvider pedagioProvider;
  LocalizationService localizationService;
  TragetoriaRepository(
      {required this.pedagioProvider, required this.localizationService});

  Future<Map<String, double>> pegarLatitudeLongitude() async {
    final localization = await localizationService.determinePosition();
    return localization;
  }

  Future<Map<String, dynamic>?> calcularTragetoria(
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
