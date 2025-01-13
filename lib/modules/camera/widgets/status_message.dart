import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatusMessage extends StatelessWidget {
  const StatusMessage({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectDetectionController controller = Get.find();

    return Center(
      child: Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.grey6,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: MainText(
          text: controller.statusMessage.value,
          color: AppColors.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
