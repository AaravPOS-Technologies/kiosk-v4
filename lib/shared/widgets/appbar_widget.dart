import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final VoidCallback? onBackPressed;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyleConstants.h3(size: 18),
      ),
      centerTitle: false,
      titleSpacing: 4,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? Colors.white,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: titleColor ?? Colors.black,
              onPressed: onBackPressed ?? () => Navigator.maybePop(context),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
