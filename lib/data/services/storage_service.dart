import 'package:flutter_good_practices/core/values/strings.dart';
import 'package:flutter_good_practices/data/interfaces/storage_interface.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService implements IStorageInterface {
  //PACOTE ESCOLHIDO FOI O GET_STORAGE E ESSA É SUA IMPLEMENTAÇÃO
  late GetStorage _box;

  @override
  Future<StorageService> init() async {
    _box = GetStorage();
    // função para zerar o storage: await _box.write(taskKey, []);

    //Escreva aqui todas as keys de providers que usarão esse serviço
    await _box.writeIfNull(configurationKey, []);
    return this;
  }

  //lê a chave atual retorna o que estiver nela
  @override
  T read<T>(String key) {
    return _box.read(key);
  }

  @override
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
