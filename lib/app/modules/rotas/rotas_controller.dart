import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/exceptions/constants_handling.dart';
import 'package:flutter_good_practices/app/core/exceptions/request_exeptions.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/data/repository/trajetoria_repository.dart';
import 'package:get/get.dart';

class RotasController extends GetxController {
  TragetoriaRepository tragetoriaRepository;
  RotasController({required this.tragetoriaRepository});

  //o ever é chamado sempre que a variavel obs dentro dela
  //é alterado. quando o failure tiver algo (some) o estado
  //dela que era none será alterado e chamará a função
  @override
  void onInit() {
    super.onInit();
    // É chamada toda vez que o objeto Rx é alterado
    ever<Option<HttpRequestFailure>>(failure, (_failure) {
      //failure é uma Option do tipo HttpRequestFailure
      //vamos descobrir qual tipo de HttpRequestFailure ela é
      //e, dependendo do tipo, mostrar uma mensagem de erro diferente
      //assim tipificando os erros para melhor compreensão do usuário

      _failure.map((failure) {
        num code;
        String message;
        if (failure is RedirectionHttpFailure) {
          code = failure.code;
          message = failure.description;
        } else if (failure is ClientHttpErrorFailure) {
          code = failure.code;
          message = failure.description;
        } else if (failure is ServerHttpErrorFailure) {
          code = failure.code;
          message = failure.description;
        } else if (failure is UnknownHttpErrorFailure) {
          code = failure.code;
          message = failure.description;
        } else if (failure is DioHttpErrorFailure) {
          code = failure.code;
          message = failure.description;
        } else {
          //caso não seja nenhum deles, retornará um erro genêrico
          code = 000;
          message = 'Erro desconhecido';
        }

        isLoading.value = false;
        //mostra uma snackbar indicando o erro
        showError(
          error: 'Erro ${code == 000 ? erroDesconhecido : code}',
          details: message, //já formatada para o usuário
        );
      });
    });
  }

  //Variáveis:
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;
  final RxBool isLoading = false.obs;
  final RxString distancia = ''.obs;
  final RxString tempoDeViagem = ''.obs;
  final RxString pedagioCusto = ''.obs;
  final RxString combustivel = ''.obs;
  final RxString numeroDePedagios = ''.obs;

  //ignore o Rx<>, é só para deixar a variavél observavel
  //foque no Option<HttpRequestFailure> failure
  //failure é uma variavel do tipo option, isso é,
  //ela representa uma opção e começa como none
  //(porque não há falha nenhuma inicialmente, e não
  //existe null no dartz, apenas none (nada) e some (algo))
  //quando ela tiver algo, o ever do GETX será chamado pq
  //seu estádo será atualizado
  final Rx<Option<HttpRequestFailure>> failure =
      Rx<Option<HttpRequestFailure>>(none());

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
    isLoading.value = true;
    double? _consumoPorLitroCarro = double.tryParse(consumoPorLitroCarro.text);
    double? _precoCombustivel = double.tryParse(precoCombustivel.text);
    bool hasLongLat = (_lat.value != 0.0) && (_long.value != 0.0);
    log('LAT: ${_lat.value}    ||    LONG: ${_long.value}\nIS: $hasLongLat');

    if (_precoCombustivel == null) {
      showError(
        error: 'Preço do combustível é inválido',
        details: 'Valor Digitado é inválido',
      );
      isLoading.value = false;
      return;
    } else if (_consumoPorLitroCarro == null) {
      showError(
        error: 'Litro é inválido',
        details: 'Valor Digitado é inválido',
      );
      isLoading.value = false;
      return;
    } else if (!hasLongLat && cepOrigem.text.isEmpty ||
        cepDestino.text.isEmpty) {
      showError(
        error: 'Digite um CEP válido',
        details: 'CEP Digitado é inválido',
      );
      isLoading.value = false;
      return;
    }

    //o parâmetro pode ser tanto um cep quanto uma cordenada (Latitude-Longitude)
    String _cepOrigem =
        hasLongLat ? '${_long.value},${_lat.value}' : cepOrigem.text;
    log('ORIGEM: $_cepOrigem');

    var mapResult = await tragetoriaRepository.calcularTragetoria(
        _cepOrigem, cepDestino.text, _consumoPorLitroCarro, _precoCombustivel);

    mapResult.fold(
      (left) {
        // O optionOf checa pra gente se tem algo
        // left (vê se não é nulo)
        failure.value = optionOf(left);
        isLoading.value = false;
      },
      (right) {
        // quando entra aqui eu tenho CERTEZA
        // que minha requisão foi um sucesso
        log(right.toString());
        distancia.value =
            right['rotas']?[0]?[distanciaKey]?['texto'].toString() ?? '';

        tempoDeViagem.value =
            right['rotas']?[0]?[tempoDeViagemKey]?['texto'].toString() ?? '';

        pedagioCusto.value =
            right['rotas']?[0]?[pedagioCustoKey]?['texto'].toString() ?? '';

        combustivel.value =
            right['rotas']?[0]?[combustivelKey].toString() ?? '';

        numeroDePedagios.value =
            right['rotas']?[0]?['numPedagios'].toString() ?? '';

        isLoading.value = false;
      },
    );
  }
}
