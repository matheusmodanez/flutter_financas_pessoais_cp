import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/meta.dart';

class MetaDetalhesPage extends StatefulWidget {
  MetaDetalhesPage({Key? key}) : super(key: key);

  @override
  State<MetaDetalhesPage> createState() => _MetaDetalhesPage();
}

class _MetaDetalhesPage extends State<MetaDetalhesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meta = ModalRoute.of(context)!.settings.arguments as Meta;

    double? rentabilidade;

    if (meta.valor < 100000) {
      if (meta.rendimento.name == 'curtoprazo') {
        rentabilidade = 20;
      } else if (meta.rendimento.name == 'medioprazo') {
        rentabilidade = 15;
      } else if (meta.rendimento.name == 'longoprazo') {
        rentabilidade = 10;
      }
    } else if (meta.valor == 100000) {
      rentabilidade = 20;
    } else if (meta.valor > 100000) {
      if (meta.rendimento.name == 'curtoprazo') {
        rentabilidade = 35;
      } else if (meta.rendimento.name == 'medioprazo') {
        rentabilidade = 30;
      } else if (meta.rendimento.name == 'longoprazo') {
        rentabilidade = 25;
      }
    }

    String tipo = '';
    if (meta.rendimento.name == 'naoinvestir') {
      tipo = 'Não Investir';
    } else if (meta.rendimento.name == 'curtoprazo') {
      tipo = 'Curto Prazo';
    } else if (meta.rendimento.name == 'medioprazo') {
      tipo = 'Médio Prazo';
    } else if (meta.rendimento.name == 'longoprazo') {
      tipo = 'Longo Prazo';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Detalhes da Meta: ${meta.titulo}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 40,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: 650,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Título',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(meta.titulo,
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Tipo de Meta',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(meta.tipo.name.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Valor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(
                      NumberFormat.simpleCurrency(locale: 'pt_BR')
                          .format(meta.valor),
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Tipo de Rendimento',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(tipo,
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Período (Data Limite)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(DateFormat('MM/dd/yyyy').format(meta.periodo),
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Descrição',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(meta.descricao.isEmpty ? '-' : meta.descricao,
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
                ListTile(
                  title: const Text('Sugestão',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(
                      meta.rendimento.name == 'naoinvestir'
                          ? 'Sem Sugestões de investimento, apenas continue com foco para guardar esse dinheiro.'
                          : 'Baseado nos apontamentos da meta criada, a sugestão é de que sejam realizados investimentos com rentabilidade de $rentabilidade% a.a.',
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
