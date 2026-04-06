import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/vet_dashboard_stats.dart';
import '../../services/vet_service.dart';

class VeterinarianPanelPage extends StatelessWidget {
  VeterinarianPanelPage({super.key});

  final VetService _vetService = VetService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            
            FutureBuilder<VetDashboardStats>(
              future: _vetService.getDashboardStats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Error al conectar con el servidor"),
                  );
                }

                final stats = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    children: [
                      _buildWelcomeCard(stats.citasHoy),
                      const SizedBox(height: 25),
                      _buildStatsGrid(stats),
                      const SizedBox(height: 30),
                      const Text("Próximas citas aparecerán aquí pronto..."),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5391B4), Color(0xFF6B4592)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Panel veterinario",
                style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("Clínica veterinaria Branquiovet",
                style: GoogleFonts.outfit(fontSize: 16, color: Colors.white70)),
            ],
          ),
          const Column(
            children: [
              Text("Salir", style: TextStyle(color: Colors.white70)),
              Icon(Icons.exit_to_app, color: Colors.white, size: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(int totalCitas) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE5B6FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("¡Bienvenido!", style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Tienes $totalCitas citas programadas para hoy", style: GoogleFonts.outfit(fontSize: 15, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(VetDashboardStats stats) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatCard("${stats.citasHoy}", "Citas hoy", const Color(0xFFF7C6E6)),
            const SizedBox(width: 15),
            _buildStatCard("${stats.pacientesRegistrados}", "Pacientes registrados", const Color(0xFF90B9D3)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _buildStatCard("${stats.solicitudesAdopcion}", "Solicitudes de adopción", const Color(0xFFB5A9E1)),
            const SizedBox(width: 15),
            _buildStatCard("\$${stats.donacionesMes}", "Donaciones/mes", const Color(0xFFD3E6CC)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(label, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
