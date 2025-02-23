import 'package:farouk/modules/home/controller/object_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_icons.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/custom_text_field.dart';
import 'package:farouk/utilities/widgets/main_text.dart';

class ObjectDetectionHeader extends StatelessWidget {
  const ObjectDetectionHeader({super.key});

  static const EdgeInsets _headerPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 24);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.grey5),
      padding: _headerPadding.copyWith(top: 32.h),
      child: Column(
        children: [
          MainText(
            text: AppStrings.detection,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: AppColors.white,
          ),
          SizedBox(height: 8.h),
          Consumer<ObjectDetectionProvider>(
            builder: (context, provider, child) {
              return CustomTextField(
                controller: provider.searchFieldController,
                hintText: AppStrings.search,
                suffixIcon: SvgPicture.asset(
                  AppIcons.search,
                  width: 16.w,
                  height: 16.h,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
