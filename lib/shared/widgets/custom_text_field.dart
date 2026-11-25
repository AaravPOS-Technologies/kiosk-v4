import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style_constants.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enable;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShowRequireIcon;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enable = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.onTap,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.inputFormatters,
    this.isShowRequireIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            maxLines: 1,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: label,
              style: TextStyleConstants.label(),
              children: [
                TextSpan(
                  text: isShowRequireIcon ? ' *' : '',
                  style: TextStyleConstants.label().copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enable,
          maxLines: maxLines,
          maxLength: maxLength,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          textInputAction: textInputAction,
          focusNode: focusNode,
          style: TextStyleConstants.h3(size: 14),
          // cursorColor: ColorConstants.color_0F3D64,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            errorMaxLines: 5,
            counterText: '',
            hintStyle:
                TextStyleConstants.bodyMedium().copyWith(color: ColorConstants.textSecondaryColor),
            errorStyle: TextStyleConstants.error().copyWith(
              color: ColorConstants.errorColor,
              overflow: TextOverflow.visible,
            ),
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstants.errorColor,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstants.errorColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
