import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/values/icons.dart';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/widgets/apontamento_card.dart';
import 'package:flutter_good_practices/app/routes/app_pages.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/shared/filter_text.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class ApontamentosView extends GetView<ApontamentosController> {
  const ApontamentosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: const Icon(abastecimento),
            label: 'Abastecimento',
            onTap: () {
              Get.toNamed(Routes.ABASTECIMENTOSSCREEN);
            },
          ),
          SpeedDialChild(
            child: const Icon(pedagio),
            label: 'Pedagio',
            onTap: () {
              Get.toNamed(Routes.PEDAGIOSSCREEN);
            },
          ),
          SpeedDialChild(
            child: const Icon(outrosGastos),
            label: 'Adicionar outro',
            onTap: () {
              Get.toNamed(Routes.GASTOAVULSOSCREEN);
            },
          ),
        ],
      ),
      children: [
        SizedBox(height: 1.0.hp),
        Container(
          margin: EdgeInsets.only(left: 5.0.wp),
          child: boldText('Bem vindo,\nRenan.', size: 28),
        ),
        SizedBox(height: 3.0.hp),
        boldText(
          'Veja aqui seus apontamentos:',
          color: Colors.grey[700]!,
          size: 16,
        ),
        Obx(
          () => FilterText(
            text: 'Filtrar:',
            filterText: controller.filtroSelecionado.value,
            choisedText: controller.filtroSelecionado.value,
            listOfChoises: const [
              todos,
              abastecimentoKey,
              outrosGastosKey,
              pedagioKey,
            ],
            onChanged: (choise) {
              if (choise != null) {
                controller.filtroSelecionado.value = choise;
              }
            },
          ),
        ),
        ...controller.abastecimento.map((e) => ApontamentoCard(e)).toList(),
      ],
    );
  }
}
