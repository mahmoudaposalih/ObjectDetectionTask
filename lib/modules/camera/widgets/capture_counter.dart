import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CaptureCounter extends StatelessWidget {
  const CaptureCounter({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectDetectionController controller = Get.find();
    return Obx(
      () => controller.countdown.value == 3
          ? SizedBox()
          : Center(
              child: Positioned(
                top: 100.h,
                child: MainText(
                  text: controller.countdown.value > 0
                      ? '${controller.countdown.value}'
                      : '',
                  fontSize: 70.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
    );
  }
}
