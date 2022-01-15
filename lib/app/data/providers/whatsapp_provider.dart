import 'package:flutter_good_practices/app/data/interfaces/launch_url_interface.dart';
import 'package:flutter_good_practices/app/data/services/lauch_url_service.dart';
import 'package:get/get.dart';

class WhatsAppProvider {
  final ILauchUrlInterface _urlLaucher = Get.find<LauchUrlService>();

  Future<void> abrirWhatsComMenssagem(String? menssage, String? number) async {
    //TODO: fazer tratamento de dados no número, tirando hífen, espaços, etc.
    const String rhNumber = '5521990870846';
    const String defaultMensage =
        'Opa,%20estou%20com%20uma%20d%C3%BAvida%20em%20rela%C3%A7%C3%A3o%20ao%20uso%20do%20aplicativo.';
    final String phoneNumber = number ?? rhNumber;
    final String finalMenssage = menssage ?? defaultMensage;

    final String finalUrl =
        'https://api.whatsapp.com/send?phone=$phoneNumber&text=$finalMenssage';
    print('final url:   $finalUrl');

    await _urlLaucher.lauchUrl(finalUrl);
  }
}
