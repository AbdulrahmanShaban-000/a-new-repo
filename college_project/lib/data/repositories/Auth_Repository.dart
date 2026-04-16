import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;

  Future<Response> login(String phone, String password) {
    return _dio.post('/Login', data: {'phone': phone, 'password': password});
  }

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String role,
    required String dateOfBirth,
    required File personalPhoto,
    required File idPhoto,
  }) async {
    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'password': password,
      'date_of_birth': dateOfBirth,
      'role': role,
      'personal_photo': await MultipartFile.fromFile(personalPhoto.path),
      'An_ID_photo': await MultipartFile.fromFile(idPhoto.path),
    });

    return DioClient.dio.post(
      '/add',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  Future<Response> logout(String token) {
    return _dio.post(
      '/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
