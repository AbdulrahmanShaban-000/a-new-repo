import 'dart:io';
import 'package:flutter/material.dart';

class ApartmentImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ApartmentImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('images')) {
      return Image.asset(imagePath, height: height, width: width, fit: fit);
    } else {
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: fit,

        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          width: width,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      );
    }
  }
}
