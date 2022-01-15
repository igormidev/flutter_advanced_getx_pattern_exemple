import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/data/models/abastecimento_model.dart';
import 'package:flutter_good_practices/app/data/repository/apontamentos_repository.dart';
import 'package:get/get.dart';

class ApontamentosController extends GetxController {
  // Note: normalmente criar uma Key Global é custoso, mas como o
  // Getx sempre dispoe ela da memoria quando o controller não
  // está sendo usado, usar keys globais tem menos impacto!

  @override
  void onInit() async {
    super.onInit();
    abastecimento.assignAll(await getAbastecimentos());
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ApontamentosRepository apontamentosRepository;
  ApontamentosController({required this.apontamentosRepository});
  final RxBool isLoading = false.obs;
  final RxString filtroSelecionado = todos.obs;
  final Rx<String?> postoSelecionado = Rx<String?>(null);
  final Rx<String?> tipoCombustivel = Rx<String?>(null);
  final Rx<File?> comprovante = Rx<File?>(null);
  final RxList<Abastecimento> abastecimento = RxList<Abastecimento>([]);
  final Rx<double> litro = 0.0.obs;
  final Rx<double> quantidade = 0.0.obs;

  Future<List<Abastecimento>> getAbastecimentos() async {
    return await apontamentosRepository.getAbastecimento();
  }

  cleanAll() {
    isLoading.value = false;
    postoSelecionado.value = null;
    tipoCombustivel.value = null;
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
    await getAbastecimentos();
    isLoading.value = false;
  }

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

  //Controllers:
  final TextEditingController litrosColocados = TextEditingController();
  final TextEditingController valorLitro = TextEditingController();
  final TextEditingController localPedagio = TextEditingController();
  final TextEditingController precoPedagio = TextEditingController();
  final TextEditingController nomeDoGasto = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
}
