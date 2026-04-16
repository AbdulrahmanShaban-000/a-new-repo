import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class BookingModel {
  final String id;
  final String apartmentArea;
  final String image;
  final DateTimeRange dateRange;
  final double totalPrice;

  BookingModel({
    required this.id,
    required this.apartmentArea,
    required this.image,
    required this.dateRange,
    required this.totalPrice,
  });
  // factory BookingModel.fromJson(Map<String, dynamic> json) {
  //   return BookingModel(
  //     id: json['id'],
  //     apartmentArea: json['area'],
  //     dateRange: json['date'],
  //     totalPrice: json['price'],
  //     image: json['image'],
  //   );
  // }
}
