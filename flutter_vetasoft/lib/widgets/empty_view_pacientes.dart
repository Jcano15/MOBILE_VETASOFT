import 'package:flutter/material.dart';

class EmptyViewPacientes extends StatelessWidget {
  final String titulo;

  const EmptyViewPacientes({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(
        child: Text(
          'Aquí va el módulo de: $titulo',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}