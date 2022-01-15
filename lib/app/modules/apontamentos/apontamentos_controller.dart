import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/exceptions/constants_handling.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/data/models/abastecimento_model.dart';
import 'package:flutter_good_practices/app/data/repository/apontamentos_repository.dart';
import 'package:get/get.dart';

class ApontamentosController extends GetxController {
  ApontamentosController({required this.apontamentosRepository});

  // Note: normalmente criar uma Key Global é custoso, mas como o
  // Getx sempre dispoe ela da memoria quando o controller não
  // está sendo usado, usar keys globais tem menos impacto!
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    abastecimento.assignAll(await getAbastecimentos(false));
  }

  //Variaveis
  final ApontamentosRepository apontamentosRepository;
  final RxBool isLoading = false.obs;
  final RxString filtroSelecionado = todos.obs;
  final Rx<String?> postoSelecionado = Rx<String?>(null);
  final Rx<String?> tipoCombustivel = Rx<String?>(null);
  final Rx<File?> comprovante = Rx<File?>(null);
  final RxList<Abastecimento> abastecimento = RxList<Abastecimento>([]);
  final Rx<double> litro = 0.0.obs;
  final Rx<double> quantidade = 0.0.obs;

  //Controllers:
  final TextEditingController litrosColocados = TextEditingController();
  final TextEditingController valorLitro = TextEditingController();

  //Controllers não implementados por falta de tempo
  final TextEditingController localPedagio = TextEditingController();
  final TextEditingController precoPedagio = TextEditingController();
  final TextEditingController nomeDoGasto = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();

  cleanAll() {
    postoSelecionado.value = null;
    tipoCombustivel.value = null;
    comprovante.value = null;
    litro.value = 0.0;
    quantidade.value = 0.0;
    litrosColocados.clear();
    valorLitro.clear();
    localPedagio.clear();
    precoPedagio.clear();
    nomeDoGasto.clear();
    descricao.clear();
    valor.clear();
  }

  //  Retorna os abastecimentos registrados no banco de dados e
  /// atualiza a lista caso o parâmetro [setAbastecimento] seja true
  Future<List<Abastecimento>> getAbastecimentos(bool setAbastecimento) async {
    isLoading.value = true;
    var lista = await apontamentosRepository.getAbastecimento();
    isLoading.value = false;
    if (setAbastecimento) abastecimento.assignAll(lista);
    return lista;
  }

  /// Faz Upload do Abastecimento para o banco de dados depois de salvar a imagem
  /// com o [getComprovante]
  Future<void> uploadAbastecimento() async {
    isLoading.value = true;
    if (comprovante.value == null) {
      showMessage(
          error: 'Faltou a imagem do comprovante!',
          details: 'Anexe uma imagem ao abastecimento');
      isLoading.value = false;
      return;
    }
    if (postoSelecionado.value == null) {
      showMessage(
          error: 'Faltou escolher o posto!',
          details: 'Selecione o posto que você\nefetuou o abastecimento');
      isLoading.value = false;
      return;
    }
    if (tipoCombustivel.value == null) {
      showMessage(
          error: 'Faltou escolher o combustível utilizado!',
          details: 'Selecione o combustível com\nque efetuou o abastecimento');
      isLoading.value = false;
      return;
    }
    try {
      double? _valorLitro = double.tryParse(valorLitro.text);
      double? _litrosColocados = double.tryParse(litrosColocados.text);

      String image = await apontamentosRepository.storageImageAndGetLink(
          comprovante.value!, abastecimentoKey);
      if (image == imageNotUploaded || image == imageNotFound) {
        return;
      }
      var abastecimento = Abastecimento(
        valorLitro: _valorLitro!,
        litrosColocados: _litrosColocados!,
        tipoDeCombustivel: tipoCombustivel.value!,
        posto: postoSelecionado.value!,
        imagemUrl: image,
      );
      await apontamentosRepository.writeApontamento(
        abastecimento.toJson(),
        abastecimentoKey,
      );
      Get.back();
    } catch (e) {
      isLoading.value = false;
    }
    cleanAll();
    getAbastecimentos(true);

    isLoading.value = false;
  }

  /// Usa o serviço de fotos para conseguir tirar uma imagem de um comprovante
  /// que pode vir tanto da câmera ou galeria, dependendo do método [isFromCamera]
  getComprovante({bool isFromCamera = false}) async {
    isLoading.value = false;

    if (isFromCamera) {
      try {
        var photo = await apontamentosRepository.imageProvider.getImageCamera();
        if (photo != null) {
          comprovante.value = photo;
        }
      } catch (e) {
        showError(error: 'Erro ao acessar câmera', details: e.toString());
      }
    } else {
      try {
        var photo =
            await apontamentosRepository.imageProvider.getImageGaleria();
        if (photo != null) {
          comprovante.value = photo;
        }
      } catch (e) {
        showError(error: 'Erro ao acessar galeria', details: e.toString());
      }
    }
  }
}
