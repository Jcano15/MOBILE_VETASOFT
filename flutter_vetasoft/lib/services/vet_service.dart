import '../models/vet_dashboard_stats.dart';
import 'api_service.dart';

class VetService {
  final ApiService _api = ApiService();

  Future<VetDashboardStats> getDashboardStats() async {
    try {
      final responses = await Future.wait([
        _api.get('/citas'),
        _api.get('/animales'),
        _api.get('/solicitudes-adopcion'),
        _api.get('/donaciones'),
      ]);

      return VetDashboardStats(
        citasHoy: (responses[0].data['data'] as List).length,
        pacientesRegistrados: (responses[1].data['data'] as List).length,
        solicitudesAdopcion: (responses[2].data['data'] as List).length,
        donacionesMes: (responses[3].data['data'] as List).length.toDouble(),
      );
    } catch (e) {
      print("Error al traer datos: $e");
      return VetDashboardStats();
    }
  }
}
