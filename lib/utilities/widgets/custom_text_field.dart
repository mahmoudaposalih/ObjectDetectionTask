import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  final EdgeInsetsGeometry? contentPadding;
  final bool? border;
  final Color? borderColor;
  final TextAlign? textAlignment;
  final Color? textColor;
  final Color? activeBorderColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.hintStyle,
    this.contentPadding,
    this.border,
    this.borderColor,
    this.textAlignment,
    this.textColor,
    this.activeBorderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      controller: widget.controller,
      validator: widget.validator,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.spMin,
        color: widget.textColor ?? AppColors.grey1,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: AppColors.grey6,
          fontSize: 12.sp,
        ),
        hintText: widget.hintText ?? "",
        suffixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.suffixIcon,
        ),
        border: OutlineInputBorder(
          borderRadius: AppStyles.borderRadius8,
          borderSide: BorderSide(
            color: AppColors.grey3,
          ),
        ),
        labelStyle: widget.hintStyle ??
            TextStyle(
              color: AppColors.grey6,
              fontSize: 14,
            ),
        alignLabelWithHint: false,
        errorText: null,
        helperText: null,
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.borderRadius8,
          borderSide: BorderSide(color: AppColors.grey9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.borderRadius8,
          borderSide: BorderSide(color: AppColors.grey3),
        ),
        contentPadding:
            widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
      ),
    );
  }
}
