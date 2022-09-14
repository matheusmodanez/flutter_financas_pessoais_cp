import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaldoTotal extends StatelessWidget {
  final double saldo;
  const SaldoTotal({Key? key, required this.saldo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Saldo Total"),
        Text(saldo.toString()),
      ],
    );
  }
}
