import 'package:flutter_good_practices/app/data/providers/configuration_provider.dart';

class BaseLayoutRepository {
  ConfiguracaoProvider configs;
  BaseLayoutRepository({required this.configs});

  Map<String, dynamic> getConfigurations() {
    final configurations = configs.readConfigs();
    return configurations;
  }

  Future<void> writeConfigurations(Map<String, dynamic> configuration) async {
    await configs.writeConfig(configuration);
  }
}
