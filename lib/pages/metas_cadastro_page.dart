import 'package:financas_pessoais/models/tipo_meta.dart';
import 'package:financas_pessoais/models/tipo_rendimento.dart';
import 'package:financas_pessoais/repository/meta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../models/meta.dart';

class MetaCadastroPage extends StatefulWidget {
  Meta? metaParaEdicao;
  MetaCadastroPage({Key? key, this.metaParaEdicao}) : super(key: key);

  @override
  State<MetaCadastroPage> createState() => _MetaCadastroPageState();
}

class _MetaCadastroPageState extends State<MetaCadastroPage> {
  final _metaRepository = MetaRepository();

  final _tituloController = TextEditingController();
  final _valorController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();

  TipoMeta _tipoMetaSelecionado = TipoMeta.Reserva;
  List<TipoMeta> _tiposDeMeta = [];
  TipoRendimento tipoRendimentoSelecionado = TipoRendimento.longoprazo;
  List<TipoRendimento> _tiposDeRendimento = [];

  @override
  void initState() {
    super.initState();

    final meta = widget.metaParaEdicao;
    if (meta != null) {
      _tituloController.text = meta.titulo;
      _valorController.text =
          NumberFormat.simpleCurrency(locale: 'pt_BR').format(meta.valor);
      _descricaoController.text = meta.descricao;
      _dataController.text = DateFormat('MM/dd/yyyy').format(meta.periodo);
      _descricaoController.text = meta.descricao;
      _tipoMetaSelecionado = meta.tipo;
      tipoRendimentoSelecionado = meta.rendimento;
    }

    carregarTipoMetas();
  }

  Future<void> carregarTipoMetas() async {
    final tiposDeMeta = await _metaRepository.listarTiposDeMeta();

    setState(() {
      _tiposDeMeta =
          tiposDeMeta.where((tipos) => tipos == _tipoMetaSelecionado).toList();
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildTitulo(),
                const SizedBox(height: 20),
                _buildData(),
                const SizedBox(height: 20),
                _buildValor(),
                const SizedBox(height: 20),
                _buildDescricao(),
                const SizedBox(height: 20),
                _buildTipoMeta(),
                const SizedBox(height: 20),
                _buildTipoRendimento(),
                const SizedBox(height: 20),
                _buildSaveButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTitulo() {
    return TextFormField(
      controller: _tituloController,
      decoration: const InputDecoration(
        hintText: 'Titulo',
        labelText: 'Título da Meta',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um título';
        }
        if (value.length < 5 || value.length > 30) {
          return 'O título deve entre 5 e 30 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildData() {
    return TextFormField(
      controller: _dataController,
      decoration: const InputDecoration(
        hintText: 'Data',
        labelText: 'Informe uma Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dataController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }

  TextFormField _buildValor() {
    return TextFormField(
      controller: _valorController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor',
        labelText: 'Valor',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

  TextFormField _buildDescricao() {
    return TextFormField(
      controller: _descricaoController,
      decoration: const InputDecoration(
        hintText: 'Descrição',
        labelText: 'Descreva sua meta',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.library_books_rounded),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Descrição';
        }
        if (value.length < 5 || value.length > 30) {
          return 'A Descrição deve entre 5 e 30 caracteres';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField _buildTipoMeta() {
    return DropdownButtonFormField<TipoMeta>(
      value: _tipoMetaSelecionado,
      onChanged: (TipoMeta? tipo) {
        setState(() {
          _tipoMetaSelecionado = tipo!;
        });
      },
      items: TipoMeta.values.map((m) {
        return DropdownMenuItem<TipoMeta>(
          value: m,
          child: Text(m.name),
        );
      }).toList(),
      decoration: const InputDecoration(
        hintText: 'Selecione o tipo de meta',
        labelText: 'Tipo de Meta',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.check_box),
      ),
      validator: (value) {
        if (value == null) {
          return 'Informe um tipo de meta';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField _buildTipoRendimento() {
    return DropdownButtonFormField<TipoRendimento>(
      value: tipoRendimentoSelecionado,
      onChanged: (TipoRendimento? tipo) {
        setState(() {
          tipoRendimentoSelecionado = tipo!;
        });
      },
      items: TipoRendimento.values.map((r) {
        String tipo = '';
        if (r.name == 'curtoprazo') {
          tipo = 'Curto Prazo';
        } else if (r.name == 'medioprazo') {
          tipo = 'Médio Prazo';
        } else if (r.name == 'longoprazo') {
          tipo = 'Longo Prazo';
        }

        return DropdownMenuItem<TipoRendimento>(
          value: r,
          child: Text(tipo),
        );
      }).toList(),
      decoration: const InputDecoration(
        hintText: 'Selecione o tipo de rendimento desejado',
        labelText: 'Tipo de Rendimento',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.check_box),
      ),
      validator: (value) {
        if (value == null) {
          return 'Informe um tipo de rendimento';
        }
        return null;
      },
    );
  }

  SizedBox _buildSaveButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Salvar Meta'),
            ),
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                final titulo = _tituloController.text;
                final periodo =
                    DateFormat('dd/MM/yyyy').parse(_dataController.text);
                final valor = NumberFormat.currency(locale: 'pt_BR')
                    .parse(_valorController.text.replaceAll('R\$', ''))
                    .toDouble();
                final descricao = _descricaoController.text;
                var tipo = _tipoMetaSelecionado;
                var rendimento = tipoRendimentoSelecionado;

                final meta = Meta(
                  titulo: titulo,
                  periodo: periodo,
                  valor: valor,
                  descricao: descricao,
                  tipo: tipo,
                  rendimento: rendimento,
                );

                await _metaRepository.criarMeta(meta);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Nova Meta adicionada com sucesso!')));

                Navigator.of(context).pop(true);
              }
            }));
  }
}
