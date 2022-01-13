abstract class IStorageInterface {
  //Escreve os arquivos na memoria do celular
  Future<void> write(String key, dynamic value);

  //Lê os arquivos da memoria do celular
  T read<T>(String key);
  Future<IStorageInterface> init();
}
