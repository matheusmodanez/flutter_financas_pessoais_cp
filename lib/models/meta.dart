import 'package:financas_pessoais/models/tipo_meta.dart';
import 'package:financas_pessoais/models/tipo_rendimento.dart';

class Meta {
  int? id;
  String titulo;
  DateTime periodo;
  double valor;
  String descricao;
  TipoMeta tipo;
  TipoRendimento rendimento;

  Meta(
      {this.id,
      required this.titulo,
      required this.periodo,
      required this.valor,
      required this.descricao,
      required this.tipo,
      required this.rendimento});
}
