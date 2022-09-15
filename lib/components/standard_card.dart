import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StandardCard extends StatelessWidget {
  String titulo;
  DateTime periodo;
  double valor;
  String tipo;
  String descricao;
  String rendimento;

  StandardCard({
    super.key,
    required this.titulo,
    required this.periodo,
    required this.valor,
    required this.tipo,
    required this.descricao,
    required this.rendimento,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 25,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(valor)}',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Meta: $tipo',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(descricao),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
