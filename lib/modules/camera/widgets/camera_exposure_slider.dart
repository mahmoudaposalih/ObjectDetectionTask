import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraExposureSlider extends StatelessWidget {
  const CameraExposureSlider({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectDetectionController controller = Get.find();

    return Obx(
      () => RotatedBox(
        quarterTurns: 3,
        child: Slider(
          thumbColor: AppColors.grey5,
          activeColor: AppColors.grey3,
          value: controller.currentExposureOffset.value,
          min: controller.minAvailableExposureOffset.value,
          max: controller.maxAvailableExposureOffset.value,
          onChanged: (value) async {
            try {
              await controller.cameraController?.setExposureOffset(value);
              controller.currentExposureOffset.value = value;
            } catch (e) {
              controller.setStatusMessage(AppStrings.exposureError);
            }
          },
        ),
      ),
    );
  }
}
