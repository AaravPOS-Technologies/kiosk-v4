import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:kiosk_app/core/constants/text_style_constants.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool showArrow;
  final bool isEnabled;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.showArrow = true,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(1.sw, 45),
        backgroundColor:
            isEnabled ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
        padding: const EdgeInsets.symmetric(vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyleConstants.button(),
          ),
        ],
      ),
    );
  }
}
