import 'package:flutter_good_practices/app/modules/suport/suport_controller.dart';
import 'package:get/get.dart';

class SuportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuportController>(
      () {
        return SuportController();
      },
    );
  }
}
