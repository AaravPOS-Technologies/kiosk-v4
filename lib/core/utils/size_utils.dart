import 'package:flutter/material.dart';

class SizeUtils {
  static const double mobileDeviceWidth = 600;
  static const double tabletDeviceWidth = 1024;

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileDeviceWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= mobileDeviceWidth;
  }
}
