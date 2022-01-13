import 'dart:io';

import 'package:flutter_good_practices/data/interfaces/photo_interface.dart';
import 'package:flutter_good_practices/data/services/photo_service.dart';
import 'package:get/get.dart';

class FotoProvider {
  final IPhotoInterface _photo = Get.find<PhotoService>();
  Future<File?> getImageGaleria() async {
    return await _photo.getGaleryImage();
  }

  Future<File?> getImageCamera() async {
    return await _photo.getGaleryImage();
  }
}
