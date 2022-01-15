import 'package:flutter_good_practices/app/data/interfaces/localization_interface.dart';
import 'package:flutter_good_practices/app/data/services/localization_service.dart';
import 'package:get/get.dart';

class LocalizationProvider {
  final ILocalizationInterface _localize = Get.find<LocalizationService>();

  Future<Map<String, dynamic>> getLocal() async {
    var local = await _localize.determinePosition();
    return local;
  }
}
