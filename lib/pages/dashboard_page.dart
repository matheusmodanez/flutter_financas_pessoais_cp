import 'package:flutter/material.dart';

import '../components/saldo_total_card.dart';
import '../repository/transacao_repository.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final _transacaoRepository = TransacaoRepository();
  late Future<double> _futureSaldo;

  @override
  void initState() {
    gerarTotal();
    super.initState();
  }

  void gerarTotal() {
    _futureSaldo = _transacaoRepository.gerarReceitaTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<double>(
          future: _futureSaldo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final saldo = snapshot.data;
                  return Container(
                    child: SaldoTotal(saldo: saldo!),
                  );
                }
              } else {
                return Container(
                  child: SaldoTotal(saldo: 0.0),
                );
              }
            }
            return Container();
          }),
    );
  }
}
