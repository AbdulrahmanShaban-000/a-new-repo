import 'dart:io';
import 'package:college_project/core/network/NetworkError.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/client',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  bool isLoading = false;
  String? errorMessage;

  

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  

  Future<Map<String, dynamic>?> login(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      errorMessage = "Please fill in all required fields.";
      notifyListeners();
      return null;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.post(
        '/Login',
        data: {'phone': phone.trim(), 'password': password},
      );

      if (response.statusCode == 200) {
        final role = response.data['user']['role'];  
        isLoading = false;
        notifyListeners();
        return {'success': true, 'role': role};
      } else {
        errorMessage = 'Invalid login credentials.';
        return {'success': false};
      }
    } on DioException catch (e) {
      errorMessage = NetworkErrorHandler.getErrorMessage(e);
      return {'success': false};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String role, // renter | tenant
    required String dateOfBirth,
    required File personalPhoto,
    required File idPhoto,
  }) async {
    _setLoading(true);
    errorMessage = null;

    try {
      final formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'password': password,
        'password_confirmation': password,
        'date_of_birth': dateOfBirth,
        'role': role,
        'personal_photo': await MultipartFile.fromFile(
          personalPhoto.path,
          filename: personalPhoto.path.split('/').last,
        ),
        'An_ID_photo': await MultipartFile.fromFile(
          idPhoto.path,
          filename: idPhoto.path.split('/').last,
        ),
      });

      final response = await _dio.post(
        '/add',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      errorMessage = NetworkErrorHandler.getErrorMessage(e);
      return false;
    } catch (_) {
      errorMessage = 'Registration failed.';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  

  Future<void> logout() async {
    errorMessage = null;
    notifyListeners();
  }



  
  Future<bool> addToFavorite(int apartmentId, String token) async {
    try {
      final response = await _dio.post(
        '/Favorite/$apartmentId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

   
  Future<bool> removeFromFavorite(int apartmentId, String token) async {
    try {
      final response = await _dio.post(
         
        '/Favorite/$apartmentId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          method: 'DELETE',  
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

 
  Future<List<dynamic>> getFavorites(String token) async {
    try {
      final response = await _dio.get(
        '/Favorites',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data; 
    } catch (e) {
      return [];
    }
  }


 

  
  Future<bool> makeReservation({
    required int apartmentId,
    required String startDate,
    required String endDate,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '/reservation/$apartmentId',
        data: {'start_date': startDate, 'end_date': endDate},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      errorMessage = e is DioException
          ? e.response?.data['message']
          : "Reservation failed";
      notifyListeners();
      return false;
    }
  }

   
  Future<List<dynamic>> getMyReservations(String token) async {
    try {
      final response = await _dio.get(
        '/reservation',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }

 
  Future<bool> approveReservation(int reservationId, String token) async {
    try {
      final response = await _dio.put(
        '/approveReservation/$reservationId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

Future<bool> addRating(
    int reservationId,
    int ratingValue,
    String token,
  ) async {
    try {
      final response = await _dio.post(
        '/rating/$reservationId',
        data: {'rating': ratingValue},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }


  Future<bool> sendFinancialRequest(double value, String token) async {
    try {
      final response = await _dio.post(
        '/sentFinancialRequest/$value',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}
