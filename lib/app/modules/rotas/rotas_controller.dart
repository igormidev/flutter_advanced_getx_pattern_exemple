import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/exceptions/constants_handling.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/data/repository/trajetoria_repository.dart';
import 'package:get/get.dart';

class RotasController extends GetxController {
  TragetoriaRepository tragetoriaRepository;
  RotasController({required this.tragetoriaRepository});

  //Variáveis:
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;
  final RxBool isLoading = false.obs;
  final RxString distancia = ''.obs;
  final RxString tempoDeViagem = ''.obs;
  final RxString pedagioCusto = ''.obs;
  final RxString combustivel = ''.obs;

  //Getters
  double get lat => _lat.value;
  double get long => _long.value;

  //Controllers:
  final TextEditingController cepOrigem = TextEditingController();
  final TextEditingController cepDestino =
      TextEditingController(text: '04094-050');
  final TextEditingController consumoPorLitroCarro =
      TextEditingController(text: '15');
  final TextEditingController precoCombustivel =
      TextEditingController(text: '7.2');

  clear() {
    _lat.value = 0.0;
    _long.value = 0.0;
    cepOrigem.clear();
    cepDestino.clear();
  }

  Future<void> getLocalization() async {
    if (isLoading.value) return;
    isLoading.value = true;

    var map = await tragetoriaRepository.pegarLatitudeLongitude();

    if (map[longitude] == null || map[latitude] == null) {
      //O erro já foi indicado para o usuário na camada de service
      isLoading.value = false;
      return;
    }

    _long.value = map[longitude]!;
    _lat.value = map[latitude]!;
    if (!(map == errorGettingMap)) {
      Get.snackbar(
        'Localização pega com sucesso',
        'Longitude: ${map[longitude].toString()}\n'
            'Latitude: ${map[latitude].toString()}',
      );
    }
    isLoading.value = false;
  }

  Future<void> getTrageto() async {
    double? _consumoPorLitroCarro = double.tryParse(consumoPorLitroCarro.text);
    double? _precoCombustivel = double.tryParse(precoCombustivel.text);

    if (_precoCombustivel == null) {
      showError(
          error: 'Preço do combustível é inválido',
          details: 'Valor Digitado é inválido');
      return;
    } else if (_consumoPorLitroCarro == null) {
      showError(
          error: 'Litro é inválido', details: 'Valor Digitado é inválido');
      return;
    }

    bool hasLongLat = (_lat.value != 0.0) && (_long.value != 0.0);
    print('LAT: ${_lat.value}    ||    LONG: ${_long.value}\nIS: $hasLongLat');

    //o parâmetro pode ser tanto um cep quanto uma cordenada (Latitude-Longitude)
    String _cepOrigem =
        hasLongLat ? '${_long.value},${_lat.value}' : cepOrigem.text;
    print('ORIGEM: $_cepOrigem');

    var map = await tragetoriaRepository.calcularTragetoria(
        _cepOrigem, cepDestino.text, _consumoPorLitroCarro, _precoCombustivel);
    log(map.toString());
    distancia.value =
        map?['rotas']?[0]?[distanciaKey]?['texto'].toString() ?? '';

    tempoDeViagem.value =
        map?['rotas']?[0]?[tempoDeViagemKey]?['texto'].toString() ?? '';

    pedagioCusto.value =
        map?['rotas']?[0]?[pedagioCustoKey]?['texto'].toString() ?? '';

    pedagioCusto.value =
        map?['rotas']?[0]?['numPedagios']?['texto'].toString() ?? '';

    combustivel.value = map?['rotas']?[0]?[combustivelKey].toString() ?? '';
  }
}
