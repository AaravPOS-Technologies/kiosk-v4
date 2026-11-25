import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:kiosk_app/core/constants/color_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: ColorConstants.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      dividerColor: ColorConstants.borderColor,
      colorScheme: const ColorScheme.light(
        primary: ColorConstants.primaryColor,
        onPrimary: ColorConstants.onPrimary,
        error: ColorConstants.errorColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: ColorConstants.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      dividerColor: ColorConstants.borderColor,
      colorScheme: const ColorScheme.light(
        primary: ColorConstants.primaryColor,
        onPrimary: ColorConstants.onPrimary,
        error: ColorConstants.errorColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
