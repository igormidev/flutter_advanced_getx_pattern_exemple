import 'package:equatable/equatable.dart';

class Abastecimento extends Equatable {
  final String? id;
  final String type = 'abastecimento';
  final String posto;
  final String tipoDeCombustivel;
  final String imagemUrl;
  final String latitude;
  final String longitude;
  final double litrosColocados;
  final double valorLitro;

  const Abastecimento({
    required this.valorLitro,
    required this.litrosColocados,
    required this.tipoDeCombustivel,
    required this.posto,
    this.imagemUrl = '',
    this.latitude = '',
    this.longitude = '',
    this.id,
  });

  Abastecimento copyWith({
    final String? id,
    final String? posto,
    final String? tipoDeCombustivel,
    final String? imagemUrl,
    final String? latitude,
    final String? longitude,
    final double? litrosColocados,
    final double? valorLitro,
  }) =>
      Abastecimento(
        id: id ?? this.id,
        posto: posto ?? this.posto,
        tipoDeCombustivel: tipoDeCombustivel ?? this.tipoDeCombustivel,
        imagemUrl: imagemUrl ?? this.imagemUrl,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        litrosColocados: litrosColocados ?? this.litrosColocados,
        valorLitro: valorLitro ?? this.valorLitro,
      );

  factory Abastecimento.fromJson(Map<String, dynamic> json) => Abastecimento(
        id: json['id'],
        posto: json['posto'],
        tipoDeCombustivel: json['tipoDeCombustivel'],
        imagemUrl: json['imagemUrl'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        litrosColocados: json['litrosColocados'],
        valorLitro: json['valorLitro'],
      );
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'posto': posto,
        'tipoDeCombustivel': tipoDeCombustivel,
        'imagemUrl': imagemUrl,
        'latitude': latitude,
        'longitude': longitude,
        'litrosColocados': litrosColocados,
        'valorLitro': valorLitro,
      };

  //equatable
  @override
  List<Object?> get props => [
        type,
        posto,
        tipoDeCombustivel,
        valorLitro,
        litrosColocados,
        latitude,
        longitude,
      ];
}
