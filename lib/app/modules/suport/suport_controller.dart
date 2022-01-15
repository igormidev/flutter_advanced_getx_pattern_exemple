import 'package:flutter_good_practices/app/data/repository/suport_repository.dart';
import 'package:get/state_manager.dart';

class SuportController extends GetxController {
  SuportRespository suportRespository;
  SuportController({required this.suportRespository});

  Future<void> sendWhatsAppMessage({String? menssage, String? number}) async {
    await suportRespository.whatsAppProvider
        .abrirWhatsComMenssagem(menssage, number);
  }
}
