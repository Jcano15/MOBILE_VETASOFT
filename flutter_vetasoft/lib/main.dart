import 'package:flutter/material.dart';
import 'ui/views/pacientes_view.dart';

import 'utils/app_routes_pacientes.dart';
import 'widgets/empty_view_pacientes.dart';

import 'ui/views/historial_medico_view.dart';
import 'utils/app_routes_historial_medico.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VetaSoft',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2a7dd7),
        ),
        useMaterial3: true,
      ),

      home: const PacientesView(),

      routes: {
        AppRoutesPacientes.detallePaciente: (context) =>
            const EmptyViewPacientes(
              titulo: 'Detalle Paciente',
            ),

        AppRoutesPacientes.registrarMascota: (context) =>
            const EmptyViewPacientes(
              titulo: 'Registrar Mascota',
            ),

        AppRoutesHistorialMedico.historial: (context) =>
            const HistorialMedicoView(),
      },
    );
  }
}