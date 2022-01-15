import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/core/values/images.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:flutter_good_practices/app/shared/custom_field.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_button.dart';
import 'package:flutter_good_practices/app/shared/custom_loading.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:flutter_good_practices/app/shared/filter_text.dart';

import 'package:get/get.dart';
import 'package:regexpattern/regexpattern.dart';

class AbastecimentoView extends StatelessWidget {
  final apontCtrl = Get.find<ApontamentosController>();

  AbastecimentoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: apontCtrl.formKey,
      child: Obx(
        () => BaseScaffold(
          children: apontCtrl.isLoading.value
              ? const [CustomLoading()]
              : [
                  boldText(
                    'Preencha os dados abaixo para adicionar\n'
                    'um abastecimento nos seus aponteamentos:',
                    color: Colors.grey[700]!,
                  ),
                  SizedBox(height: 4.0.hp),
                  Container(
                    color: Colors.white,
                    width: double.maxFinite,
                    child: Obx(
                      () => SizedBox(
                        height: 220,
                        child: apontCtrl.comprovante.value == null
                            ? Image.asset(missingImage)
                            : Image.file(apontCtrl.comprovante.value!,
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  CustomButton(
                      onPressed: () async {
                        Get.bottomSheet(Container(
                          height: 40 * (Get.height / 100),
                          color: Colors.white,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await apontCtrl.getComprovante(
                                        isFromCamera: true);
                                    Get.back();
                                  },
                                  child: boldText('Abrir Câmera')),
                              TextButton(
                                  onPressed: () async {
                                    await apontCtrl.getComprovante(
                                        isFromCamera: false);
                                    Get.back();
                                  },
                                  child: boldText('Abrir Galeria')),
                            ],
                          ),
                        ));
                      },
                      text: 'Fotografar Comprovanete'),
                  SizedBox(height: 1.0.hp),
                  Row(
                    children: [
                      Expanded(
                        child: CustomField(
                          controller: apontCtrl.litrosColocados,
                          label: 'Litros Colocados',
                          onlyNumbers: true,
                          validator: (text) {
                            if (text == null ||
                                text.isEmpty ||
                                RegExp(RegexPattern.numericOnly).hasMatch(
                                    text.contains('.') ? text : '$text.') ||
                                (double.tryParse(text) == null)) {
                              return 'Escreva um número';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            double? numParsed = double.tryParse(text);
                            if (numParsed != null) {
                              apontCtrl.litro.value = numParsed;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 1.0.hp),
                      Expanded(
                        child: CustomField(
                          controller: apontCtrl.valorLitro,
                          label: 'Valor do litro',
                          onlyNumbers: true,
                          validator: (text) {
                            if (text == null ||
                                text.isEmpty ||
                                RegExp(RegexPattern.numericOnly)
                                    .hasMatch(text) ||
                                (double.tryParse(text) == null)) {
                              return 'Escreva um número\ncom vírgula!';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            double? numParsed = double.tryParse(text);
                            if (numParsed != null) {
                              apontCtrl.quantidade.value = numParsed;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.0.hp),
                  Obx(() {
                    bool isNotZero = apontCtrl.litro.value != 0.0 &&
                        apontCtrl.quantidade.value != 0.0;
                    String text = isNotZero
                        ? (apontCtrl.litro.value * apontCtrl.quantidade.value)
                            .toStringAsFixed(2)
                        : '0.0';
                    return normalText('Quantidade Total: $text');
                  }),
                  SizedBox(height: 1.0.hp),
                  Obx(
                    () => FilterText(
                      text: 'Tipo de Combustível:',
                      filterText: 'Selecione a Galosina',
                      choisedText: apontCtrl.tipoCombustivel.value,
                      listOfChoises: const [
                        comum,
                        etanol,
                        diesel,
                        gasNatural,
                        outro
                      ],
                      onChanged: (choise) {
                        if (choise != null) {
                          apontCtrl.tipoCombustivel.value = choise;
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => FilterText(
                      text: 'Posto:',
                      filterText: 'Escolha o posto',
                      choisedText: apontCtrl.postoSelecionado.value,
                      listOfChoises: const [
                        ipiranga,
                        shell,
                        extra,
                        petrobras,
                        outro
                      ],
                      onChanged: (choise) {
                        if (choise != null) {
                          apontCtrl.postoSelecionado.value = choise;
                        }
                      },
                    ),
                  ),
                  CustomButton(
                      onPressed: () async {
                        if (apontCtrl.formKey.currentState!.validate()) {
                          await apontCtrl.uploadAbastecimento();
                        }
                      },
                      text: 'Salvar abastecimento'),
                ],
        ),
      ),
    );
  }
}
