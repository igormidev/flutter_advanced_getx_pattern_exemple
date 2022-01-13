import 'package:flutter_good_practices/core/values/strings.dart';
import 'package:flutter_good_practices/data/interfaces/storage_interface.dart';
import 'package:flutter_good_practices/data/services/storage_service.dart';
import 'package:get/get.dart';

class ConfiguracaoProvider {
  final IStorageInterface _storage = Get.find<StorageService>();

  // EXEMPLO DE CONFIGURAÇÃO ARMAZENADA NO SERVIÇO DE STORAGE
  // {
  //   configurationKey:
  //     {
  //       'themeDark': false,
  //       'language': 'PT-BR',
  //     }
  // }

  // Essas funções não são assinconas pq o stotage já foi pego
  // na inicialização do aplicativo
  Map<String, dynamic> readConfigs() {
    final configs = _storage.read<Map<String, dynamic>>(configurationKey);
    return configs;
  }

  Future<void> writeConfig(Map<String, dynamic> configs) async {
    await _storage.write(configurationKey, configs);
  }
}
