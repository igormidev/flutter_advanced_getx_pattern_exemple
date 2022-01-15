import 'package:equatable/equatable.dart';

class Pedagio extends Equatable {
  final String type = 'pedagio';
  final String local;
  final double valor;
  final String? id;

  const Pedagio({
    required this.local,
    required this.valor,
    this.id,
  });

  Pedagio copyWith({
    final String? id,
    final String? local,
    final double? valor,
  }) =>
      Pedagio(
        id: id ?? this.id,
        local: local ?? this.local,
        valor: valor ?? this.valor,
      );

  factory Pedagio.fromJson(Map<String, dynamic> json) => Pedagio(
        id: json['id'],
        valor: json['valor'],
        local: json['local'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'valor': valor,
        'local': local,
      };

  @override
  List<Object?> get props => [valor, local, type];
}
