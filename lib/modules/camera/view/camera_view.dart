import 'package:camera/camera.dart';
import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/modules/camera/widgets/camera_exposure_slider.dart';
import 'package:farouk/modules/camera/widgets/camera_zoom_slider.dart';
import 'package:farouk/modules/camera/widgets/capture_counter.dart';
import 'package:farouk/modules/camera/widgets/status_message.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraView extends GetView<ObjectDetectionController> {
  final String title;

  const CameraView({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => () async {
        await controller.stopAndDisposeCamera();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: MainText(
            text: '${AppStrings.detecting} $title',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Obx(
          () {
            if (!controller.isCameraInitialized.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(controller.cameraController!),
                CaptureCounter(),
                Positioned(
                  bottom: 16.h,
                  left: 0.w,
                  right: 0.w,
                  child: CameraZoomSlider(),
                ),
                Positioned(
                  top: 56.h,
                  right: 8.w,
                  child: CameraExposureSlider(),
                ),
                controller.countdown.value != 3 ? SizedBox() : StatusMessage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
