import 'package:flutter/material.dart';

class NavigationUtils {
  NavigationUtils._();

  // 1. Push - Open a new screen
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // 2. Pop - Go back
  static void pop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) {
    Navigator.pop<T>(context, result);
  }

  // 3. Push Replacement - Replace current screen
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // 4. Push And Remove Until - Clear previous screens
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
