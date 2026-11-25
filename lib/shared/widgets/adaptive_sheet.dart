import 'package:flutter/material.dart';

class AdaptiveSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    double? height,
    required Widget child,
    double breakpoint = 600,
    double tabletWidth = 420,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // MOBILE: Bottom sheet
    if (screenWidth < breakpoint) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        useSafeArea: true,
        builder: (context) {
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          final screenHeight = MediaQuery.sizeOf(context).height;

          final sheetHeight = height ?? screenHeight * 0.3;

          return AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: SizedBox(
              height: sheetHeight,
              child: child,
            ),
          );
        },
      );
    }

    // TABLET: Right side panel
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close panel',
      barrierColor: Colors.black.withValues(alpha: 0.35),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: tabletWidth + 55,
            height: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // PANEL
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: tabletWidth,
                  child: Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 8,
                    child: child,
                  ),
                ),

                // CLOSE BUTTON
                Positioned(
                  left: 0,
                  top: MediaQuery.sizeOf(context).height * 0.5 - 20,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
