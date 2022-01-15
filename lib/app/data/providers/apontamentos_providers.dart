import 'dart:io';

import 'package:flutter_good_practices/app/data/interfaces/nosql_database_interface.dart';
import 'package:flutter_good_practices/app/data/services/database_service.dart';
import 'package:get/get.dart';

class ApontamentosProvider {
  final INoSqlDatabaseInterface _db = Get.find<DatabaseService>();

  Future<String> storageImageAndGetLink(File file, String key) async {
    return await _db.addImageToDataBase(file, key);
  }

  Future<void> writeApontamento(
    Map<String, dynamic> apontamento,
    String collectionName,
  ) async {
    await _db.writeDocumentInDatabase(apontamento, collectionName);
  }

  Future<void> removeApontamento(String path) async {
    await _db.deleteDocumentInDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getApontamentoList(
    String collection,
  ) async {
    final List<Map<String, dynamic>> abastecimentos =
        await _db.readCollectionDatabase(collection);
    List<Map<String, dynamic>> list = [];
    for (var doc in abastecimentos) {
      list.add(doc);
    }
    return list;
  }
}
