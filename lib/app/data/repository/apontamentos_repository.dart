import 'dart:io';
import 'package:flutter_good_practices/app/core/values/strings.dart';
import 'package:flutter_good_practices/app/data/models/abastecimento_model.dart';
import 'package:flutter_good_practices/app/data/models/outros_gastos_model.dart';
import 'package:flutter_good_practices/app/data/models/pedagio_model.dart';
import 'package:flutter_good_practices/app/data/providers/apontamentos_providers.dart';
import 'package:flutter_good_practices/app/data/providers/pegar_foto_provider.dart';

class ApontamentosRepository {
  FotoProvider imageProvider;
  ApontamentosProvider apontamentosProvider;
  ApontamentosRepository(
      {required this.imageProvider, required this.apontamentosProvider});

  Future<String> storageImageAndGetLink(File file, String key) async {
    return await apontamentosProvider.storageImageAndGetLink(file, key);
  }

  Future<File?> getGaleryImage() async {
    File? image = await imageProvider.getImageGaleria();
    return image;
  }

  Future<File?> getCameraImage() async {
    File? image = await imageProvider.getImageCamera();
    return image;
  }

  Future<void> deleteApontamento(String path) async {
    await apontamentosProvider.removeApontamento(path);
  }

  Future<void> writeApontamento(Map<String, dynamic> json, String type) async {
    await apontamentosProvider.writeApontamento(json, type);
  }

  Future<List<Abastecimento>> getAbastecimento() async {
    var apontamentos =
        await apontamentosProvider.getApontamentoList(abastecimentoKey);

    List<Abastecimento> list = [];
    for (var doc in apontamentos) {
      list.add(Abastecimento.fromJson(doc));
    }
    return list;
  }

  Future<List<OutrosGastos>> getOutrosGastos() async {
    var apontamentos =
        await apontamentosProvider.getApontamentoList(outrosGastosKey);
    List<OutrosGastos> list = [];
    for (var doc in apontamentos) {
      list.add(OutrosGastos.fromJson(doc));
    }
    return list;
  }

  Future<List<Pedagio>> getPedagio() async {
    var apontamentos =
        await apontamentosProvider.getApontamentoList(pedagioKey);
    List<Pedagio> list = [];
    for (var doc in apontamentos) {
      list.add(Pedagio.fromJson(doc));
    }
    return list;
  }
}
