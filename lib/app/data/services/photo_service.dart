import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/data/interfaces/photo_interface.dart';
import 'package:image_picker/image_picker.dart';
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
      showError(
          error: 'Ative a permissão pro aplicativo usar a câmera!',
          details: e.code);
    } catch (e) {
      showError(
          error: 'Erro ao pegar imagem da galeria!', details: e.toString());
    }
    //Ao retornar o valor nulo o arquivo não será exibido, será como se nada
    // tivesse ocorrido
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
      showError(
        error: 'Ative a permissão pro aplicativo usar a galeria!',
        details: e.code,
      );
    } catch (e) {
      showError(
          error: 'Erro ao pegar imagem da galeria!', details: e.toString());
    }
    //Ao retornar o valor nulo o arquivo não será exibido, será como se nada
    // tivesse ocorrido
    return null;
  }
}
