import 'package:flutter_good_practices/app/data/providers/apontamentos_providers.dart';
import 'package:flutter_good_practices/app/data/providers/pegar_foto_provider.dart';
import 'package:flutter_good_practices/app/data/repository/apontamentos_repository.dart';
import 'package:flutter_good_practices/app/data/services/database_service.dart';
import 'package:flutter_good_practices/app/data/services/photo_service.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:get/get.dart';

class ApontamentosBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PhotoService>(PhotoService());
    Get.put<DatabaseService>(DatabaseService());
    Get.lazyPut<ApontamentosController>(
      () {
        return ApontamentosController(
          apontamentosRepository: ApontamentosRepository(
            apontamentosProvider: ApontamentosProvider(),
            imageProvider: FotoProvider(),
          ),
        );
      },
    );
  }
}
