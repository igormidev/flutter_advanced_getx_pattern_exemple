import 'package:flutter_good_practices/app/data/providers/whatsapp_provider.dart';

class SuportRespository {
  WhatsAppProvider whatsAppProvider;
  SuportRespository({required this.whatsAppProvider});

  Future<void> openSuport({String? message, String? number}) async {
    await whatsAppProvider.abrirWhatsComMenssagem(message, number);
  }
}
