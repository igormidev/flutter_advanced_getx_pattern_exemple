abstract class IStorageInterface {
  /// Escreve um objeto [value] na memoria do celular e o
  /// seu local é a registra na chave [key] que for passada.
  Future<void> write(String key, dynamic value);

  /// Lê os arquivos da memoria do celular que estiverem
  /// armazenados na chave [key];
  T read<T>(String key);

  /// Inicia o Storage do celular e puxa os arquivos armazenados
  /// nas chaves para a memória RAM. Dessa forma, a função write
  /// não precisa ser assincrona pois os dados são carregados antes
  /// mesmo da aplicação iniciar
  Future<IStorageInterface> init();
}
