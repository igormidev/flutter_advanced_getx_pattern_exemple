abstract class ILocalizationInterface {
  /// Retorna um mapa com chaves longitude e latitude
  /// que posteriormente serão usados para determinar
  /// o local exato do usuário.
  Future<Map<String, double>> determinePosition();
}
