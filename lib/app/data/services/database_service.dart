import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_good_practices/app/core/exceptions/constants_handling.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/data/interfaces/nosql_database_interface.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    try {
      final List<Map<String, dynamic>> listOfObject = [];
      final collection =
          await FirebaseFirestore.instance.collection(path).get();
      for (var doc in collection.docs) {
        listOfObject.add(doc.data());
      }
      return listOfObject;
    }
    // Quando um erro acontecer, será mostrado ao usuário um indicativo de
    // erro e a lista vázia será retornada, assim não acarretando em erros.
    on FirebaseException catch (e) {
      showError(
        error: 'Erro ao fazer consulta em banco\nde dados. Tente mais tarde.',
        details: e.message!,
      );
      return errorGettingListOfMap;
    } catch (e) {
      showError(
        error: 'Erro desconhecido, contacte o suporte',
        details: e.toString(),
      );
      return errorGettingListOfMap;
    }
  }

  @override
  Future<void> writeDocumentInDatabase(
      Map<String, dynamic> json, String collection) async {
    try {
      String id = const Uuid().v4();
      json['id'] = id;
      await FirebaseFirestore.instance.collection(collection).doc(id).set(json);
    } on FirebaseException catch (e) {
      showError(
        error:
            'Erro ao salvar apontamento no banco\nde dados. Tente mais tarde.',
        details: e.message!,
      );
    } catch (e) {
      showError(
        error: 'Erro desconhecido, contacte o suporte',
        details: e.toString(),
      );
    }
  }

  @override
  Future<String> addImageToDataBase(File file, String key) async {
    String fileName = const Uuid().v4();
    // Create a Reference to the file
    try {
      await FirebaseStorage.instance
          .ref()
          .child(key)
          .child(fileName)
          .putFile(file);
    }
    // Quando um erro acontecer, será mostrado ao usuário um indicativo de
    // erro e uma constante será retornada ao qual, quando for recebida pelo
    // controller, encerrará a função.
    on FirebaseException catch (e) {
      showError(
        error: 'Erro ao salvar imagem no banco de dados',
        details: e.message!,
      );
      return imageNotUploaded;
    } catch (e) {
      showError(
        error: 'Erro desconhecido, contacte o suporte',
        details: e.toString(),
      );
      return imageNotUploaded;
    }

    final url = await FirebaseStorage.instance
        .ref()
        .child(key)
        .child(fileName)
        .getDownloadURL()
        .catchError((error) {
      showError(error: 'Erro ao conseguir link da imagem', details: error);
      return imageNotFound;
    });
    return url;
  }
}
