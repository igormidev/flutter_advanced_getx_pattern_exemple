import 'package:flutter_good_practices/app/data/providers/consultar_pedagios_provider.dart';
import 'package:flutter_good_practices/app/data/providers/localization_provider.dart';
import 'package:flutter_good_practices/app/data/repository/trajetoria_repository.dart';
import 'package:flutter_good_practices/app/data/services/api_request_service.dart';
import 'package:flutter_good_practices/app/data/services/localization_service.dart';
import 'package:flutter_good_practices/app/modules/rotas/rotas_controller.dart';
import 'package:get/get.dart';

class RotasBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(LocalizationService());
    Get.lazyPut<RotasController>(
      () {
        return RotasController(
          tragetoriaRepository: TragetoriaRepository(
            pedagioProvider: ConsultarPedagioProvider(),
            localizationProvider: LocalizationProvider(),
          ),
        );
      },
    );
  }
}
