abstract class INoSqlDatabaseInterface {
  Future<void> writeDocumentInDatabase(
      Map<String, dynamic> json, String collection);
  Future<void> deleteDocumentInDatabase(String path);
  Future<List<Map<String, dynamic>>> readCollectionDatabase<T>(String path);
}
