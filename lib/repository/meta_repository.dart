import 'package:financas_pessoais/models/tipo_meta.dart';
import 'package:financas_pessoais/models/tipo_rendimento.dart';
import '../database/database_manager.dart';
import '../models/meta.dart';

class MetaRepository {
  Future<List<Meta>> listarMetas() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            metas.id, 
            metas.titulo,
            metas.periodo,
            metas.valor, 
            metas.descricao,
            metas.tipo,
            metas.rendimento,
          FROM metas
''');

    return rows
        .map(
          (row) => Meta(
            id: row['id'],
            titulo: row['titulo'],
            periodo: DateTime.fromMillisecondsSinceEpoch(row['periodo']),
            valor: row['valor'],
            descricao: row['descricao'],
            tipo: TipoMeta.values[row['tipo']],
            rendimento: TipoRendimento.values[row['rendimento']],
          ),
        )
        .toList();
  }

  Future<List<TipoMeta>> listarTiposDeMeta() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT metas.tipo FROM metas ''');

    return rows.map((row) => TipoMeta.values[row['tipo']]).toList();
  }

  Future<void> removerMeta(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('metas', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> criarMeta(Meta meta) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("metas", {
      "titulo": meta.titulo,
      "periodo": meta.periodo,
      "valor": meta.valor,
      "descricao": meta.descricao,
      "tipo": meta.tipo,
      "rendimento": meta.rendimento
    });
  }
}
