abstract class ILocalizationInterface {
  // retorna um mapa com chaves longitude e latitude
  // que ṕosteriormente serão usados para determinar
  // o local exato do usuário
  Future<Map<String, double>> determinePosition();
}
