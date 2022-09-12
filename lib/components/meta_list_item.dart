import 'package:financas_pessoais/models/tipo_meta.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/meta.dart';

class MetaListItem extends StatelessWidget {
  final Meta meta;
  const MetaListItem({Key? key, required this.meta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(meta.titulo),
      subtitle: Text(DateFormat('MM/dd/yyyy').format(meta.periodo)),
      trailing: Text(
        NumberFormat.simpleCurrency(locale: 'pt_BR').format(meta.valor),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/meta-detalhes', arguments: meta);
      },
    );
  }
}
