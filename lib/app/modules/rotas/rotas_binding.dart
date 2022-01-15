import 'package:flutter_good_practices/app/modules/rotas/rotas_controller.dart';
import 'package:get/get.dart';

class RotasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RotasController>(
      () {
        return RotasController();
      },
    );
  }
}
