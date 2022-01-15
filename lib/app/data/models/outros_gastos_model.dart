import 'package:equatable/equatable.dart';

class OutrosGastos extends Equatable {
  final String? id;
  final String texto;
  final String descricao;
  final double valor;

  const OutrosGastos({
    required this.texto,
    required this.descricao,
    required this.valor,
    this.id,
  });

  OutrosGastos copyWith({
    final String? id,
    final String? texto,
    final String? descricao,
    final double? valor,
  }) =>
      OutrosGastos(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        valor: valor ?? this.valor,
        texto: texto ?? this.texto,
      );

  factory OutrosGastos.fromJson(Map<String, dynamic> json) => OutrosGastos(
        texto: json['texto'],
        id: json['id'],
        descricao: json['descricao'],
        valor: json['valor'],
      );

  Map<String, dynamic> toJson() => {
        'texto': texto,
        'id': id,
        'descricao': descricao,
        'valor': valor,
      };

  @override
  List<Object?> get props => [valor, descricao, texto];
}
