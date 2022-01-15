import 'package:flutter_good_practices/app/data/providers/whatsapp_provider.dart';
import 'package:flutter_good_practices/app/data/repository/suport_repository.dart';
import 'package:flutter_good_practices/app/data/services/lauch_url_service.dart';
import 'package:flutter_good_practices/app/modules/suport/suport_controller.dart';
import 'package:get/get.dart';

class SuportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LauchUrlService());
    Get.lazyPut<SuportController>(
      () {
        return SuportController(
            suportRespository: SuportRespository(
          whatsAppProvider: WhatsAppProvider(),
        ));
      },
    );
  }
}
