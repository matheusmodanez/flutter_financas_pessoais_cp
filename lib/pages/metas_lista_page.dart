import 'package:financas_pessoais/components/meta_list_item.dart';
import 'package:financas_pessoais/models/meta.dart';
import 'package:financas_pessoais/pages/metas_cadastro_page.dart';
import 'package:financas_pessoais/repository/meta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MetasListaPage extends StatefulWidget {
  const MetasListaPage({Key? key}) : super(key: key);

  @override
  State<MetasListaPage> createState() => _MetasListaPage();
}

class _MetasListaPage extends State<MetasListaPage> {
  final _metasRepository = MetaRepository();
  late Future<List<Meta>> _futureMetas;

  @override
  void initState() {
    carregarMetas();
    super.initState();
  }

  void carregarMetas() {
    _futureMetas = _metasRepository.listarMetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas')),
      body: FutureBuilder<List<Meta>>(
          future: _futureMetas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final metas = snapshot.data ?? [];
              return ListView.separated(
                  itemCount: metas.length,
                  itemBuilder: (context, index) {
                    final meta = metas[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              await _metasRepository.removerMeta(meta.id!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Meta removida com sucesso')));
                              setState(() {
                                metas.removeAt(index);
                              });
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Remover',
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              var success = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MetaCadastroPage(
                                    metaParaEdicao: meta,
                                  ),
                                ),
                              ) as bool?;

                              if (success != null && success) {
                                setState(() {
                                  carregarMetas();
                                });
                              }
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Editar',
                          ),
                        ],
                      ),
                      child: MetaListItem(meta: meta),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider());
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? metaCadastrada = await Navigator.of(context)
                .pushNamed('/meta-cadastro') as bool?;

            if (metaCadastrada != null && metaCadastrada) {
              setState(() {
                carregarMetas();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}
