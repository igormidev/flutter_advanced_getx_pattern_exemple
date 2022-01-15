import 'package:flutter_good_practices/app/data/interfaces/api_request_interface.dart';
import 'package:flutter_good_practices/app/data/services/api_request_service.dart';
import 'package:get/get.dart';

class ConsultarPedagioProvider {
  final IHttpInterface _httpRequest = Get.find<ApiService>();

  // Sei que não deveria instanciar uma String cm tokken dentro de uma classe
  // posteriormente isso será mudado e provavelmente vai para o arquivo .env
  final String _meuTokken = '5ad40957db90917925b4773422095c20';
  Future<Map<String, dynamic>>? calcularTragetoria(
    String cepOrigem,
    String cepDestilo,
    double consumoPorLitroCarro,
    double precoCombustivel, //vai acabar ficando hard coded
    {
    String eixos = '2',
    String veiculo = 'carro',
    bool paradas = true,
  }) async {
    //Exemplo de rota: 'https://rotasbrasil.com.br/api/v3?pontos=Curitiba,pr;20040-070&veiculo=caminhao&eixos=6&token=5ad40957db90917925b4773422095c20';
    const String baseUrl = 'https://rotasbrasil.com.br/api/v3';
    final response = await _httpRequest.makeJsonRequest(
      url: baseUrl,
      params: {
        'pontos': '$cepOrigem;$cepDestilo',
        'veiculo': veiculo,
        'eixos': eixos,
        'consumo': consumoPorLitroCarro,
        'combustivel': consumoPorLitroCarro,
        'paradas': paradas,
        'token': _meuTokken,
      },
    );
    return response;
  }
}
