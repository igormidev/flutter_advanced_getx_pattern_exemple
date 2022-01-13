import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_good_practices/data/interfaces/photo_interface.dart';
import 'package:get/state_manager.dart';

class PhotoService extends GetxService implements IPhotoInterface {
  @override
  Future<File?> getCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      return imageTemporary;
    } on PlatformException catch (e) {
      //TODO: implementar exceção caso o usuário não dê permissão de acesso à câmera

    }
    return null;
  }

  @override
  Future<File?> getGaleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageLocation = File(image.path);
      return imageLocation;
    } on PlatformException catch (e) {
      //TODO: implementar exceção caso o usuário não dê permissão de acesso à câmera
    }
    return null;
  }
}
