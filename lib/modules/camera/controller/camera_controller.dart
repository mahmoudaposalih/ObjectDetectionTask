import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:farouk/modules/details/view/details_view.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:collection/collection.dart';

class CameraObjectDetectionProvider extends ChangeNotifier {
  double currentZoomLevel = 1.0;
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  double minAvailableExposureOffset = 1.0;
  double maxAvailableExposureOffset = 1.0;
  double currentExposureOffset = 1.0;

  bool isDetecting = false;
  bool isDisposing = false;
  int countdown = 3;
  String statusMessage = AppStrings.initializing;

  static List<CameraDescription> cameras = [];
  CameraController? cameraController;
  bool isCameraInitialized = false;

  void setStatusMessage(String message) {
    statusMessage = message;
    notifyListeners();
  }

  Future<void> loadTfliteModel() async {
    try {
      setStatusMessage('Loading model...');
      await Tflite.loadModel(
        model: "assets/models/model.tflite",
        labels: "assets/models/model.txt",
      );
      setStatusMessage('Model loaded successfully.');
      debugPrint("---------loadTfliteModel");
    } catch (e) {
      setStatusMessage('Model loading error: $e');
      debugPrint("---------loadTfliteModel2");
    }
  }

  Future<void> initializeCamera(BuildContext context, String objectName) async {
    try {
      cameras = cameras.isEmpty ? await availableCameras() : cameras;
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

      minAvailableZoom = await cameraController!.getMinZoomLevel();
      maxAvailableZoom = await cameraController!.getMaxZoomLevel();
      minAvailableExposureOffset =
          await cameraController!.getMinExposureOffset();
      maxAvailableExposureOffset =
          await cameraController!.getMaxExposureOffset();

      setStatusMessage(AppStrings.camReady);
      debugPrint("------------objectName-----------$objectName");
      cameraController!.startImageStream(
          (image) => processCameraImage(image, context, objectName));

      isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      setStatusMessage('Camera initialization error: $e');
    }
  }

  Future<void> processCameraImage(
      CameraImage image, BuildContext context, String objectName) async {
    debugPrint("------processCameraImage------$isDisposing-----$isDetecting-");
    if (isDetecting || isDisposing) return;

    isDetecting = true;

    try {
      final recognitions = await Tflite.detectObjectOnFrame(
        model: "YOLO",
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0.0,
        imageStd: 255.0,
        threshold: 0.1,
        numResultsPerClass: 1,
      );

      final detectedObject = recognitions?.firstWhereOrNull(
        (r) {
          debugPrint("------------------------------");
          debugPrint("-----------$objectName-------------------");
          debugPrint(
              "-----------${r["detectedClass"].toString().trim()}-------------------");
          return r["detectedClass"].toString().trim() == objectName.trim() &&
              (r["confidenceInClass"] ?? 0) >= 0.5;
        },
      );

      if (detectedObject != null) {
        setStatusMessage('${AppStrings.objectDetected} $objectName!');
        final picture = await cameraController?.takePicture();

        await countdownTimer();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              title: objectName,
              dateTime: DateTime.now().toString(),
              file: picture,
              confidence: detectedObject["confidenceInClass"],
            ),
          ),
        );

        await stopAndDisposeCamera();
      } else {
        setStatusMessage(AppStrings.noMatching);
      }
    } catch (e) {
      setStatusMessage('Error processing image: $e');
    } finally {
      isDetecting = false;
    }
  }

  Future<void> countdownTimer() async {
    for (int i = 3; i > 0; i--) {
      countdown = i;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    }
    countdown = 0;
    isCameraInitialized = false;

    notifyListeners();
  }

  Future<void> onCameraZoomChange(double zoom) async {
    try {
      await cameraController?.setZoomLevel(zoom);
      currentZoomLevel = zoom;
      notifyListeners();
    } catch (e) {
      setStatusMessage(AppStrings.zoomError);
    }
  }

  Future<void> onCameraExposureChange(double exposure) async {
    try {
      await cameraController?.setExposureOffset(exposure);
      currentExposureOffset = exposure;
      notifyListeners();
    } catch (e) {
      setStatusMessage(AppStrings.exposureError);
    }
  }

  Future<void> stopAndDisposeCamera() async {
    if (isDisposing) return;
    isDisposing = true;

    final completer = Completer<void>();

    try {
      if (cameraController != null) {
        await cameraController!.stopImageStream();
        await Future.delayed(const Duration(milliseconds: 200));
        await cameraController!.dispose();
        cameraController = null;
      }
      await Tflite.close();
    } catch (e) {
      debugPrint("Error disposing resources: $e");
    } finally {
      completer.complete();
    }

    await completer.future;
    notifyListeners();
  }

  @override
  void dispose() {
    stopAndDisposeCamera();
    super.dispose();
  }

  void reset() {
    countdown = 3;
    isDisposing = false;
    isDetecting = false;
    notifyListeners();
  }
}
