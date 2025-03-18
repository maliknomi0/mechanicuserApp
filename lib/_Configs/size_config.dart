import 'package:flutter/material.dart';

class ResponsiveUtils {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ResponsiveUtils(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // 📌 Dynamic Height & Width
  double height(double scale) => screenHeight * scale; // Custom height based on percentage
  double width(double scale) => screenWidth * scale;   // Custom width based on percentage

  // 📌 Responsive Spacing
  SizedBox get xs => SizedBox(height: screenHeight * 0.005, width: screenWidth * 0.005);
  SizedBox get sm => SizedBox(height: screenHeight * 0.01, width: screenWidth * 0.01);
  SizedBox get md => SizedBox(height: screenHeight * 0.02, width: screenWidth * 0.02);
  SizedBox get lg => SizedBox(height: screenHeight * 0.03, width: screenWidth * 0.03);
  SizedBox get xl => SizedBox(height: screenHeight * 0.04, width: screenWidth * 0.04);
  SizedBox get xxl => SizedBox(height: screenHeight * 0.06, width: screenWidth * 0.06);
}
