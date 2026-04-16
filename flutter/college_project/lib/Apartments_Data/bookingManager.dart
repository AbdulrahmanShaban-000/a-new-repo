import 'package:college_project/Apartments_Data/bookingModel.dart';

class BookingManager {
  static List<BookingModel> myBookings = [];
  static List<BookingModel> deletedBookings = [];

  static void addBooking(BookingModel booking) {
    myBookings.add(booking);
  }

  static void cancelBooking(BookingModel booking) {
    myBookings.removeWhere((item) => item.id == booking.id);
    deletedBookings.add(booking);
  }

  static void restoreBooking(BookingModel booking) {
    deletedBookings.removeWhere((item) => item.id == booking.id);
    myBookings.add(booking);
  }
}
/*import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookingManager {
  static List<BookingModel> myBookings = [];

  // دالة لحفظ القائمة في ذاكرة الهاتف
  static Future<void> saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    // تحويل القائمة إلى نص JSON
    String encodedData = jsonEncode(
      myBookings.map((b) => b.toJson()).toList(),
    );
    await prefs.setString('user_bookings', encodedData);
  }

  // دالة لاستعادة القائمة عند فتح التطبيق أو تسجيل الدخول
  static Future<void> loadFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('user_bookings');
    if (data != null) {
      Iterable decoded = jsonDecode(data);
      myBookings = decoded.map((item) => BookingModel.fromJson(item)).toList();
    }
  }
} */