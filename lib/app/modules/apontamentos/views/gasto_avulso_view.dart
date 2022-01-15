import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/widgets/apontamento_field.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_button.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:get/get.dart';

class GastoAvulsoView extends StatelessWidget {
  final apontCtrl = Get.find<ApontamentosController>();
  GastoAvulsoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      children: [
        boldText(
          'Preencha os dados abaixo para adicionar '
          'um abastecimento nos seus aponteamentos:',
          color: Colors.grey[700]!,
          size: 16,
        ),
        SizedBox(height: 4.0.hp),
        SizedBox(height: 1.0.hp),
        CustomButton(onPressed: () async {}, text: 'Fotografar Comprovanete'),
        CustomButton(onPressed: () async {}, text: 'Salvar abastecimento'),
      ],
    );
  }
}
