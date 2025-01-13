import 'dart:io';

import 'package:camera/camera.dart';
import 'package:farouk/modules/details/binding/details_binding.dart';
import 'package:farouk/modules/details/view/details_view.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';

class ObjectDetectionController extends GetxController {
  RxDouble currentZoomLevel = 1.0.obs;
  RxDouble minAvailableZoom = 1.0.obs;
  RxDouble maxAvailableZoom = 1.0.obs;
  RxDouble minAvailableExposureOffset = 1.0.obs;
  RxDouble maxAvailableExposureOffset = 1.0.obs;
  RxDouble currentExposureOffset = 1.0.obs;
  Rx<bool> isDetecting = false.obs;
  Rx<bool> isDisposing = false.obs;
  RxInt countdown = 3.obs;
  Rx<String> statusMessage = AppStrings.initializing.obs;
  static List<CameraDescription> cameras = [];
  CameraController? cameraController;
  var passedTitle = Get.arguments;
  RxBool isCameraInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTfliteModel();
    initializeCamera();
  }

  void setStatusMessage(String message) {
    statusMessage.value = message;
  }

  Future<void> _loadTfliteModel() async {
    try {
      setStatusMessage('Loading model...');
      await Tflite.loadModel(
        model: "assets/models/model.tflite",
        labels: "assets/models/model.txt",
      );

      setStatusMessage('Model loaded successfully.');
    } catch (e) {
      setStatusMessage('Camera Error');
    }
  }

  Future<void> initializeCamera() async {
    try {
      if (cameras.isEmpty) {
        cameras = await availableCameras();
      }
      final camera = cameras.first;

      setStatusMessage('Initializing camera...');
      cameraController = CameraController(
        camera,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.yuv420
            : ImageFormatGroup.bgra8888,
      );

      await cameraController!.initialize();

      minAvailableZoom.value = await cameraController!.getMinZoomLevel();
      maxAvailableZoom.value = await cameraController!.getMaxZoomLevel();
      minAvailableExposureOffset.value =
          await cameraController!.getMinExposureOffset();
      maxAvailableExposureOffset.value =
          await cameraController!.getMaxExposureOffset();

      setStatusMessage(AppStrings.camReady);

      cameraController!.startImageStream(processCameraImage);
    } catch (e) {
      setStatusMessage(AppStrings.camError);
    }
    isCameraInitialized.value = true;
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (isDetecting.value || isDisposing.value) return;

    isDetecting.value = true;

    try {
      var recognitions = await Tflite.detectObjectOnFrame(
        model: "YOLO",
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0.0,
        imageStd: 255.0,
        threshold: 0.1,
        numResultsPerClass: 1,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        var found = recognitions.firstWhere(
          (r) =>
              r["detectedClass"] == passedTitle &&
              (r["confidenceInClass"] ?? 0) >= 0.5,
          orElse: () => null,
        );
        if (found != null) {
          setStatusMessage('${AppStrings.objectDetected} $passedTitle!');
          var capturedPicture = await cameraController?.takePicture();

          countdown.value = 3;
          await Future.delayed(Duration(seconds: 1), () => countdown.value = 2);
          await Future.delayed(Duration(seconds: 1), () => countdown.value = 1);
          await Future.delayed(Duration(seconds: 1), () => countdown.value = 0);

          Get.off(() => DetailsView(), binding: DetailsBinding(), arguments: {
            'title': passedTitle,
            'dateTime': DateTime.now().toString(),
            'imagePath': capturedPicture,
            'confidence': found["confidenceInClass"]
          });

          await stopAndDisposeCamera();

          return;
        } else {
          setStatusMessage(AppStrings.noMatching);
        }
      } else {
        setStatusMessage(AppStrings.noObjectDetected);
      }
    } catch (e) {
      setStatusMessage(AppStrings.initializing);
    } finally {
      isDetecting.value = false;
    }
  }

  Future<void> stopAndDisposeCamera() async {
    isDisposing.value = true;
    try {
      if (cameraController != null) {
        await cameraController!.stopImageStream();
        await Future.delayed(const Duration(milliseconds: 200));
        await cameraController!.dispose();
        cameraController = null;
      }
    } catch (e) {
      debugPrint("Error disposing camera: $e");
    }
    try {
      await Tflite.close();
    } catch (e) {
      debugPrint("Error closing TFLite: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    stopAndDisposeCamera();
  }
}
