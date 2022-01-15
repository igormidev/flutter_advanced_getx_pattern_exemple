import 'dart:io';

abstract class IPhotoInterface {
  /// O [getGaleryImage] busca um arquivo de imagem
  /// na galeria e pode retornar um valor [null] caso
  /// o usuario não dê permissão de accesso ou não
  /// escolha nenhuma imagem.
  Future<File?> getGaleryImage();

  /// O [getCameraImage] busca um arquivo de imagem
  /// na câmera e pode retornar um valor [null] caso
  /// o usuario não dê permissão de accesso ou não
  /// escolha nenhuma imagem.
  Future<File?> getCameraImage();
}
