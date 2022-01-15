abstract class ILauchUrlInterface {
  /// Verifica de pode  abrir uma url e assim o faz.
  /// A [url] que for passada será aberta.
  Future<void> lauchUrl(String url);
}
