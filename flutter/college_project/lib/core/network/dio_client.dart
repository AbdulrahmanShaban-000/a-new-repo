import 'package:dio/dio.dart';

class DioClient {
   
  static final Dio _dio = Dio(
    BaseOptions(
       
      baseUrl: 'http://10.0.2.2:8000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;

   
  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

   
  static void clearToken() {
    _dio.options.headers.remove('Authorization');
  }
}
