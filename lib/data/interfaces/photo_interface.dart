import 'dart:io';

abstract class IPhotoInterface {
  Future<File?> getGaleryImage();
  Future<File?> getCameraImage();
}
