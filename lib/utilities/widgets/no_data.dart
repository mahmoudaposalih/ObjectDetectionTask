import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_icons.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.noData),
          MainText(
            text: 'No data available',
            fontSize: 18.sp,
            color: AppColors.grey7,
          ),
        ],
      ),
    );
  }
}
