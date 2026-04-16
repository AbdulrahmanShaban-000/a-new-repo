import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String bookingsKey = 'user_bookings';
  static const String apartmentsKey = 'user_apartments';

  

  static Future<void> saveBookings(List<Map<String, dynamic>> bookings) async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(bookings);
    await prefs.setString(bookingsKey, encoded);
  }

  static Future<List<dynamic>> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(bookingsKey);
    if (data == null) return [];
    return jsonDecode(data);
  }

  

  static Future<void> saveApartments(
    List<Map<String, dynamic>> apartments,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(apartments);
    await prefs.setString(apartmentsKey, encoded);
  }

  static Future<List<dynamic>> loadApartments() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(apartmentsKey);
    if (data == null) return [];
    return jsonDecode(data);
  }

  

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
