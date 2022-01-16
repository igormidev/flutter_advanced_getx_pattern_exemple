import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/modules/rotas/rotas_controller.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_button.dart';
import 'package:flutter_good_practices/app/shared/custom_field.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RotasConsultaView extends GetView<RotasController> {
  const RotasConsultaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      children: [
        boldText('Calcule seu trajeto', size: 25.0),
        SizedBox(height: 1.0.hp),
        boldText(
          'Veja as informais mais relevantes sobre o trajeto que você '
          'fara, como pédagios, custos e outros.',
          color: Colors.grey,
        ),
        SizedBox(height: 1.0.hp),
        Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange),
            SizedBox(width: 1.0.wp),
            boldText('Lembre-se, há poucos tokens', color: Colors.deepOrange),
          ],
        ),
        SizedBox(height: 3.0.hp),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => (controller.lat == 0.0) || (controller.long == 0.0)
                    ? CustomField(
                        label: 'Cep Origem',
                        controller: controller.cepOrigem,
                      )
                    : Row(
                        children: [
                          boldText('Localização validada', size: 17),
                          const Icon(Icons.check, color: Colors.green, size: 30)
                        ],
                      ),
              ),
            ),
            SizedBox(width: 4.0.wp),
            InkWell(
              onTap: () async {
                await controller.getLocalization();
              },
              child: Column(
                children: [
                  const Icon(Icons.location_on),
                  boldText('Pegar\nLocal', size: 9, align: TextAlign.center),
                ],
              ),
            ),
            SizedBox(width: 1.0.wp),
          ],
        ),
        SizedBox(height: 2.0.hp),
        CustomField(
          label: 'Cep Destino',
          controller: controller.cepDestino,
        ),
        SizedBox(height: 2.0.hp),
        CustomField(
          label: 'Quilômetros que o veículo faz por litro',
          controller: controller.consumoPorLitroCarro,
        ),
        SizedBox(height: 2.0.hp),
        CustomField(
          label: 'Preço do Combustível',
          controller: controller.precoCombustivel,
        ),
        SizedBox(height: 2.0.hp),
        Obx(
          () => CustomButton(
            isEnabled: !controller.isLoading.value,
            onPressed: () async {
              await controller.getTrageto();
            },
            text: 'Ver trageto',
          ),
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              // Verifica se tem a distância
              if (controller.distancia.value.isNotEmpty)
                boldText('Distância:', color: Colors.deepPurple, size: 16),
              if (controller.distancia.value.isNotEmpty)
                normalText(controller.distancia.value),

              const Divider(),
              // Verifica se tem a estimativa de tempo
              if (controller.tempoDeViagem.value.isNotEmpty)
                boldText('Extimativa do Tempo de Viagem:',
                    color: Colors.deepPurple, size: 16),
              if (controller.tempoDeViagem.value.isNotEmpty)
                normalText(controller.tempoDeViagem.value),

              const Divider(),
              // Verifica se tem a estimativa do gasto com gasolina
              if (controller.combustivel.value.isNotEmpty)
                boldText('Gasto com Gasolina (Estimativa):',
                    color: Colors.deepPurple, size: 16),
              if (controller.combustivel.value.isNotEmpty)
                normalText('R\$ ' + controller.combustivel.value),

              const Divider(),
              // Verifica se tem o número de pedágios
              if (controller.numeroDePedagios.value.isNotEmpty)
                boldText('Número de pedágios:',
                    color: Colors.deepPurple, size: 16),
              if (controller.numeroDePedagios.value.isNotEmpty)
                normalText('R\$ ' + controller.numeroDePedagios.value),

              const Divider(),
              // Verifica se tem o preço dos pedágios somados
              if (controller.pedagioCusto.value.isNotEmpty)
                boldText('Gasto com Pedágio:',
                    color: Colors.deepPurple, size: 16),
              if (controller.pedagioCusto.value.isNotEmpty)
                normalText('R\$ ' + controller.pedagioCusto.value),
            ],
          ),
        ),
        SizedBox(height: 4.0.hp),
      ],
    );
  }
}
