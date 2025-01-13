import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final List<Shadow>? shadow;

  const MainText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.shadow,
    this.letterSpacing,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        letterSpacing: letterSpacing ?? 0,
        color: color ?? AppColors.grey1,
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: height,
        shadows: shadow,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
