import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_good_practices/app/data/interfaces/nosql_database_interface.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService extends GetxService implements INoSqlDatabaseInterface {
  @override
  Future<void> deleteDocumentInDatabase(String path) async {
    await FirebaseFirestore.instance.doc(path).delete().catchError((e) {
      //TUDO: tratamento de erros com exeptions
      //personalizadas para o firestore
    });
  }

  @override
  Future<List<Map<String, dynamic>>> readCollectionDatabase<T>(
      String path) async {
    final List<Map<String, dynamic>> listOfObject = [];
    final collection =
        await FirebaseFirestore.instance.collection(path).get().catchError((e) {
      //TUDO: tratamento de erros com exeptions
      //personalizadas para o firestore
    });
    for (var doc in collection.docs) {
      listOfObject.add(doc.data());
    }
    return listOfObject;
  }

  @override
  Future<void> writeDocumentInDatabase(
      Map<String, dynamic> json, String collection) async {
    String id = const Uuid().v4();
    json['id'] = id;
    await FirebaseFirestore.instance.collection(collection).doc(id).set(json);
  }

  @override
  Future<String> addImageToDataBase(File file, String key) async {
    String fileName = const Uuid().v4();
    // Create a Reference to the file
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(key)
        .child(fileName)
        .putFile(file);

    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(key)
        .child(fileName)
        .getDownloadURL();
  }
}
