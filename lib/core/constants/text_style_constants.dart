import 'package:flutter/material.dart';

import 'color_constants.dart';

class TextStyleConstants {
  static const String fontFamilyPoppin = 'Poppins';

// BOLD
  static TextStyle h1({double? size}) => TextStyle(
        fontSize: size ?? 20,
        fontWeight: FontWeight.w700,
        color: ColorConstants.textPrimaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // SEMI-BOLD
  static TextStyle h2({double? size}) => TextStyle(
        fontSize: size ?? 20,
        fontWeight: FontWeight.w600,
        color: ColorConstants.textPrimaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // Medium
  static TextStyle h3({double? size}) => TextStyle(
        fontSize: size ?? 16,
        fontWeight: FontWeight.w500,
        color: ColorConstants.textPrimaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // REGULAR
  static TextStyle bodyLarge({double? size}) => TextStyle(
        fontSize: size ?? 16,
        fontWeight: FontWeight.w400,
        color: ColorConstants.textPrimaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // REGULAR
  static TextStyle bodyMedium({double? size}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w400,
        color: ColorConstants.textPrimaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // LABEL
  static TextStyle label({double? size}) => TextStyle(
        fontSize: size ?? 16,
        fontWeight: FontWeight.w500,
        color: ColorConstants.textSecondaryColor,
        fontFamily: fontFamilyPoppin,
      );

  // Button
  static TextStyle button({double? size}) => TextStyle(
        fontSize: size ?? 16,
        fontWeight: FontWeight.w500,
        color: ColorConstants.onPrimary,
        fontFamily: fontFamilyPoppin,
      );

  // ERROR
  static TextStyle error({double? size}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: ColorConstants.errorColor,
        fontFamily: fontFamilyPoppin,
      );
}
