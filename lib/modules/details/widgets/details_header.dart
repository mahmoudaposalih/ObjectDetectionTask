import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';

import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.grey7,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey5,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: MainText(
        text: AppStrings.details,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        textAlign: TextAlign.center,
      ),
    );
  }
}
