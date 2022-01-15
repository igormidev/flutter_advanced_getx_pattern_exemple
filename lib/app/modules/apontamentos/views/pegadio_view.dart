import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:get/get.dart';

class PedagioView extends StatelessWidget {
  final apontCtrl = Get.find<ApontamentosController>();

  PedagioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      children: [
        boldText(
          'Preencha os dados abaixo para adicionar '
          'um pedágio nos seus aponteamentos:',
          color: Colors.grey[700]!,
          size: 16,
        ),
        Center(child: boldText('Função não implementada\nainda...', size: 30)),
      ],
    );
  }
}
