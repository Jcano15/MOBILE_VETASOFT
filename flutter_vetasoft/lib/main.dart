import 'package:flutter/material.dart';
import 'ui/register_client_view.dart';
import 'ui/pets_view.dart';
import 'package:flutter_vetasoft/ui/add_animal_view.dart';
import 'package:flutter_vetasoft/ui/donations_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vetasoft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF755198)),
        useMaterial3: true,
      ),
      // vista clientes por ahora
      home: DonationsView(),
    );
  }
}