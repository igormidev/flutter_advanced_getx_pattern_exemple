import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  /// Feito para atingir uma responsividade maior na hora
  /// de definir tamanhos de espaçamento, se adequando ao contexto.
  double get wp => (Get.width * (this / 100));
  double get hp => (Get.height * (this / 100));
}

extension ResponsiveText on double {
  /// Feito para atingir uma responsividade maior na hora
  /// de definir o tamanho da tela, se adequando ao contexto.
  double get sp => Get.width / 100 * (this / 3);
}

//documentação desse padrão em:
//https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
extension HexColor on Color {
  /// Feito para conseguir gerar uma cor apartid do seu código HEX
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Feito para converter uma string para o formato Hex, uma extensão natural da String.
  /// O parâmetro [leadingHashSign] define se terá o simbolo de # no inicio ou não.
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
