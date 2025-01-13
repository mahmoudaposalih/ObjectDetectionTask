import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraZoomSlider extends StatelessWidget {
  const CameraZoomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    ObjectDetectionController controller = Get.find();

    return Obx(
      () => Slider(
        thumbColor: AppColors.grey5,
        activeColor: AppColors.grey3,
        value: controller.currentZoomLevel.value,
        min: controller.minAvailableZoom.value,
        max: controller.maxAvailableZoom.value,
        divisions: 100,
        label: "${controller.currentZoomLevel.value.toStringAsFixed(1)}x",
        onChanged: (value) async {
          try {
            await controller.cameraController?.setZoomLevel(value);
            controller.currentZoomLevel.value = value;
          } catch (e) {
            controller.setStatusMessage(AppStrings.zoomError);
          }
        },
      ),
    );
  }
}
