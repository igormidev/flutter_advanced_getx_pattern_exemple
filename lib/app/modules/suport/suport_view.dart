import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/modules/suport/suport_controller.dart';
import 'package:flutter_good_practices/app/shared/base_scaffold.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:get/state_manager.dart';

class SuportView extends GetView<SuportController> {
  const SuportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      children: [
        const Icon(
          Icons.support_agent_outlined,
          size: 200,
          color: Colors.deepPurple,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            boldText('Equipe de Suporte', size: 25, color: Colors.deepPurple),
            SizedBox(height: 2.0.hp),
            Center(
                child: boldText(
              'Precisa de suporte ou tem alguma dúvida? Contacte a nossa equipe',
              size: 25,
              color: Colors.deepPurple,
              align: TextAlign.center,
            )),
            SizedBox(height: 8.0.hp),
            TextButton(
              onPressed: () async {
                await controller.sendWhatsAppMessage();
              },
              child: boldText('Mandar Mensagem'),
            ),
          ],
        ),
      ],
    );
  }
}
