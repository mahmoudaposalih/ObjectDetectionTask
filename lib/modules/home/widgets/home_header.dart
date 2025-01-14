import 'package:farouk/modules/home/controller/home_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_icons.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/custom_text_field.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.grey5),
      padding:
          EdgeInsets.only(top: 32.h, left: 24.w, right: 24.w, bottom: 24.h),
      child: Column(
        children: [
          MainText(
            text: AppStrings.detection,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: AppColors.white,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: Get.find<HomeController>().searchController,
            hintText: AppStrings.search,
            suffixIcon:
                SvgPicture.asset(AppIcons.search, width: 16.w, height: 16.h),
          ),
        ],
      ),
    );
  }
}
