import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';

class DetailsView extends StatelessWidget {
  final Map<String, dynamic> object;
  const DetailsView(this.object, {Key? key}) : super(key: key);

  buildText(String text, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        boldText(text),
        normalText(description),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(object['type']);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            if ((object['type'] == 'abastecimento'))
              SizedBox(
                width: double.maxFinite,
                child: Image.network(object['imagemUrl'], fit: BoxFit.fitWidth),
              ),
            if ((object['type'] == 'abastecimento'))
              buildText('Posto:', object['posto']),
            if ((object['type'] == 'abastecimento'))
              buildText('Tipo:', object['tipoDeCombustivel']),
            if ((object['type'] == 'abastecimento'))
              buildText(
                  'Litros Colocados:', object['litrosColocados'].toString()),
            if ((object['type'] == 'abastecimento'))
              buildText('Preço Litro:', object['valorLitro'].toString()),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
