import 'package:flutter/material.dart';

class DonationsView extends StatelessWidget {
  const DonationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donaciones')),
      body: const Center(
        child: Text('Pantalla de Donaciones\n(En construcción)', textAlign: TextAlign.center,),
      ),
    );
  }
}
