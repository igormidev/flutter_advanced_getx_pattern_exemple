import 'dart:io';

abstract class INoSqlDatabaseInterface {
  /// Escreve o arquivo passado como [json] no Banco
  /// de dados não relacional que implementar essa função
  /// que tem o outro parâmetro obrigatório a coleção
  /// [collection] que ele pertence no DataBase.
  Future<void> writeDocumentInDatabase(
      Map<String, dynamic> json, String collection);

  /// Deleta o arquivo passado no caminho [path] do banco que dados.
  Future<void> deleteDocumentInDatabase(String path);

  /// Lê a coleção passada no caminho [path] inteira e retorna uma lista
  /// de Mapas que posteriormente serão convertidos para objetos pelo <T>.fromMap()
  Future<List<Map<String, dynamic>>> readCollectionDatabase<T>(String path);

  ///adiciona uma imagem ao banco de dados e retorna o caminho dela
  Future<String> addImageToDataBase(File file, String key);
}
