import 'package:flutter/material.dart';
// 💡 Importamos la página que construimos
import 'package:flutter_vetasoft/pages/veterianrioview/veterinarian_panel_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetaSoft Branquiovet',
      debugShowCheckedModeBanner: false, // Quitamos la banda roja de "Debug"
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4592)),
        useMaterial3: true,
      ),
      // 🚀 ¡Aquí está el truco! Ponemos tu panel como la página inicial
      home: VeterinarianPanelPage(),
    );
  }
}
