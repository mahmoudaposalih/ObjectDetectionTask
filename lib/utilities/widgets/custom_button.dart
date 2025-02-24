import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_styles.dart';
import 'package:farouk/utilities/widgets/transparent_inkwell.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Function() onPressed;
  final double? width;
  final String text;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final WidgetStateProperty<Color>? backgroundColor;

  const CustomButton({
    super.key,
    this.color,
    required this.onPressed,
    this.width,
    required this.text,
    this.textColor,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TransparentInkwell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height ?? 48,
        decoration: BoxDecoration(
          color: color ?? AppColors.blueDark,
          borderRadius: AppStyles.borderRadius8,
        ),
        child: MainText(
          text: text,
          color: textColor ?? AppColors.white,
          fontSize: fontSize ?? 16.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
