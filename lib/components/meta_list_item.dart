import 'package:financas_pessoais/components/standard_card.dart';
import 'package:flutter/material.dart';

import '../models/meta.dart';

class MetaListItem extends StatelessWidget {
  final Meta meta;
  const MetaListItem({Key? key, required this.meta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/meta-detalhes', arguments: meta);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.8),
                  Colors.green.withOpacity(0.2),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: StandardCard(
              titulo: meta.titulo,
              periodo: meta.periodo,
              valor: meta.valor,
              tipo: meta.tipo.name,
              descricao: meta.descricao,
              rendimento: meta.rendimento.name,
            ),
          ),
        ),
      ),
    );
  }
}
