import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/data/models/abastecimento_model.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';

class ApontamentoCard extends StatelessWidget {
  final Abastecimento apontamento;
  const ApontamentoCard(this.apontamento, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 3.0.wp),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText('Abastecimento no posto ${apontamento.posto}'),
                  normalText(
                      'R\$ ' +
                          (apontamento.valorLitro * apontamento.litrosColocados)
                              .toString() +
                          ' Gastos em Galolina' +
                          apontamento.tipoDeCombustivel,
                      color: Colors.deepPurple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
