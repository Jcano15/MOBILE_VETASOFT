import 'package:dio/dio.dart';

class ApiService {
  // 💡 MODO EXPERTO:
  // Si le pasas una variable 'API_URL' por terminal la usa, 
  // si no (por defecto), usa tu túnel de Dev Tunnels.
  static const String _baseUrl = String.fromEnvironment(
    'API_URL', 
    defaultValue: 'http://10.0.2.2:4000/api' // Fíjate en el /api al final
  );

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  // 2. Patrón Singleton: Una única instancia para toda la app
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 💡 TOKEN DE PRUEBA
          const String myToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6InZldGVyaWFuYXJpb0BnbWFpbC5jb20iLCJyb2xlSWQiOjQsImlhdCI6MTc3NTYxODk5MiwiZXhwIjoxNzc2MjIzNzkyfQ.VMTgG8TlQf4VHoPssP7B2TXwwu4zGkbAgtx2GtfDkzQ';
          
          options.headers['Authorization'] = 'Bearer $myToken';
          
          print('🚀 Petición: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print('❌ Error API: ${e.response?.statusCode} - ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // 3. Métodos genéricos para peticiones
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}
