import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/historial_medico_model.dart';

class ApiServiceHistorialMedico {

  static const String baseUrl =
      'http://localhost:4000/api/historial-medico';

  static Future<List<HistorialMedico>> fetchHistorial()async {

    /// 🔥 PON AQUÍ TU TOKEN REAL
    const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE2LCJlbWFpbCI6ImlhbkBnbWFpbC5jb20iLCJyb2xlSWQiOjEsInJvbGVOYW1lIjoiQWRtaW4gZnVuZGFjaW9uIiwiaWF0IjoxNzc0OTM5MjE0LCJleHAiOjE3NzU1NDQwMTR9.74ITIlrb4PtRsJwVPaFO0zsitQuOI4xZiTksyBbc-gQ';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // 🔥 CLAVE
      },
    );

    print("URL: $baseUrl");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List data = decoded['data'] ?? [];

      return data.map((e) {
        return HistorialMedico.fromJson(e);
      }).toList();
    } else {
      throw Exception(
          'Error ${response.statusCode}: ${response.body}');
    }
  }
}