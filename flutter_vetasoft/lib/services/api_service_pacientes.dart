import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/historial_medico_model.dart';

class ApiServiceHistorialMedico {

  /// 🔥 CAMBIA SOLO ESTO SEGÚN NECESITES
  static const bool useNgrok = true;

  static const String ngrokUrl = 'https://abc123.ngrok-free.app'; // 👈 pega tu URL aquí

  static String get _baseUrl {

    /// 🌐 WEB
    if (kIsWeb) {
      return 'http://localhost:4000/api';
    }

    /// 🌍 NGROK (celular o pruebas externas)
    if (useNgrok) {
      return '$ngrokUrl/api';
    }

    /// 🤖 EMULADOR
    return 'http://10.0.2.2:4000/api';
  }

  static Future<List<HistorialMedico>> fetchHistorial() async {
    final uri = Uri.parse('$_baseUrl/historial');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded['data'] ?? decoded;

      return data
          .map((e) => HistorialMedico.fromJson(e))
          .toList();
    }

    throw Exception('Error al cargar historial médico');
  }
}