import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/meta.dart';

class MetaDetalhesPage extends StatelessWidget {
  const MetaDetalhesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meta = ModalRoute.of(context)!.settings.arguments as Meta;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(meta.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Título'),
              subtitle: Text(meta.titulo),
            ),
            ListTile(
              title: const Text('Tipo de Meta'),
              subtitle: Text(meta.tipo.toString()),
            ),
            ListTile(
              title: const Text('Valor'),
              subtitle: Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(meta.valor)),
            ),
            ListTile(
              title: const Text('Tipo de Rendimento'),
              subtitle: Text(meta.rendimento.toString()),
            ),
            ListTile(
              title: const Text('Período em dias'),
              subtitle: Text(DateFormat('MM/dd/yyyy').format(meta.periodo)),
            ),
            ListTile(
              title: const Text('Descrição'),
              subtitle: Text(meta.descricao.isEmpty ? '-' : meta.descricao),
            ),
          ],
        ),
      ),
    );
  }
}
