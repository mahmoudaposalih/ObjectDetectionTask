import 'package:camera/camera.dart';
import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:farouk/modules/camera/widgets/camera_exposure_slider.dart';
import 'package:farouk/modules/camera/widgets/camera_zoom_slider.dart';
import 'package:farouk/modules/camera/widgets/capture_counter.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  final String title;

  const CameraView({super.key, required this.title});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final objectDetectionController =
          Provider.of<CameraObjectDetectionProvider>(context, listen: false);
      objectDetectionController.reset();
      objectDetectionController.loadTfliteModel();
      objectDetectionController.initializeCamera(context, widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraObjectDetectionProvider>(
      builder: (context, controller, child) {
        debugPrint(
            "---------------------------${controller.cameraController == null}");
        return PopScope(
          onPopInvokedWithResult: (didPop, result) => () async {
            await controller.stopAndDisposeCamera();
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              title: MainText(
                text: '${AppStrings.detecting} ${widget.title}',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            body: !controller.isCameraInitialized
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      CameraPreview(controller.cameraController!),
                      CaptureCounter(),
                      Positioned(
                        bottom: 16.h,
                        left: 0.w,
                        right: 0.w,
                        child: ZoomControlSlider(),
                      ),
                      Positioned(
                        top: 56.h,
                        right: 8.w,
                        child: ExposureControlSlider(),
                      ),
                      controller.countdown == 3
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.all(16.r),
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: AppColors.grey6,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: MainText(
                                  text: controller.statusMessage,
                                  color: AppColors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
