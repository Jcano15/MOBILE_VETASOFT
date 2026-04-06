import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ─── Configuración base ────────────────────────────────────────────────────
  // URL pública habilitada (Devtunnels)
  static const String baseUrl = 'https://13mc2m95-4000.use2.devtunnels.ms/api';

  // TODO: Reemplazar con el token obtenido del login real del admin
  static const String _tempToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI4LCJlbWFpbCI6ImFkbWluQHZldGFzb2Z0LmNvbSIsInJvbGVJZCI6MSwicm9sZU5hbWUiOiJBZG1pbiBmdW5kYWNpb24iLCJpYXQiOjE3NzU1MTE0NjIsImV4cCI6MTc3NjExNjI2Mn0.zC9z8GgSeRnHl_W7WuvjXnIKSyOFDOlppiIjQXNxxrs';

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_tempToken',
  };

  // ─── Crear cliente ─────────────────────────────────────────────────────────
  /// POST /api/clientes
  /// Retorna el cliente_id creado o lanza excepción con mensaje de error
  static Future<int> createCliente(Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/clientes');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode(body),
    );

    final data = _parseResponse(response, 'crear cliente');
    return data['data']['cliente_id'] as int;
  }

  // ─── Crear animal ──────────────────────────────────────────────────────────
  /// POST /api/animales
  static Future<Map<String, dynamic>> createAnimal(
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$baseUrl/animales');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode(body),
    );

    return _parseResponse(response, 'crear animal');
  }
  // ─── Obtener animales por cliente ────────────────────────────────────────────
  /// GET /api/animales?cliente_id={id}
  static Future<List<Map<String, dynamic>>> getAnimalesByCliente(int clienteId) async {
    final uri = Uri.parse('$baseUrl/animales?cliente_id=$clienteId');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = json['message'] ?? json['error'] ?? 'Error al obtener mascotas (${response.statusCode})';
      throw Exception(msg);
    }

    final decoded = jsonDecode(response.body);

    List<dynamic> rawList;
    if (decoded is List) {
      rawList = decoded;
    } else if (decoded is Map && decoded['data'] is List) {
      rawList = decoded['data'] as List<dynamic>;
    } else {
      throw Exception('Formato de mascotas inesperado');
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .toList();
  }
  // ─── Obtener razas ─────────────────────────────────────────────────────────
  /// GET /api/razas — Retorna lista de razas [{raza_id, nombre, ...}]
  static Future<List<Map<String, dynamic>>> getRazas() async {
    final uri = Uri.parse('$baseUrl/razas');
    final response = await http.get(uri, headers: _headers);

    // Debug: imprime la respuesta real para verificar la estructura
    // ignore: avoid_print
    print('[ApiService] GET /razas → ${response.statusCode}: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = json['message'] ?? json['error'] ?? 'Error al obtener razas (${response.statusCode})';
      throw Exception(msg);
    }

    final decoded = jsonDecode(response.body);

    // Acepta tanto [{...}] directo como {data: [{...}]} o {success, data:[...]}
    List<dynamic> rawList;
    if (decoded is List) {
      rawList = decoded;
    } else if (decoded is Map && decoded['data'] is List) {
      rawList = decoded['data'] as List<dynamic>;
    } else {
      throw Exception('Formato de razas inesperado');
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  // ─── Helper de respuesta ───────────────────────────────────────────────────
  static Map<String, dynamic> _parseResponse(
    http.Response response,
    String context,
  ) {
    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json;
    }

    final msg =
        json['message'] ?? json['error'] ?? 'Error desconocido ($context)';
    throw Exception(msg);
  }
}
