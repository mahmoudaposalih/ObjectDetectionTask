import 'package:farouk/modules/camera/binding/camera_binding.dart';
import 'package:farouk/modules/camera/view/camera_view.dart';
import 'package:farouk/modules/home/controller/home_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Obx(
      () => FloatingActionButton.extended(
        onPressed: () {
          if (controller.selectedObject.value.isNotEmpty) {
            Get.to(
              () => CameraView(title: controller.selectedObject.value),
              binding: CameraBinding(),
              arguments: controller.selectedObject.value,
            );
            controller.searchController.clear();
            controller.selectedObject.value == '';
          }
        },
        label: MainText(
          text: AppStrings.getStarted,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        icon: Icon(
          Icons.arrow_forward,
          color: AppColors.white,
        ),
        backgroundColor: controller.selectedObject.value.isEmpty
            ? AppColors.grey7
            : AppColors.black,
      ),
    );
  }
}
