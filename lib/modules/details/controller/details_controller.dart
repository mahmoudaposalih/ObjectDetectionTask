import 'package:camera/camera.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  late XFile? file;
  late String title;
  late double confidence;
  late String dateTime;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    file = args["imagePath"] as XFile?;
    title = args["title"] ?? "Unknown";
    confidence = args["confidence"] ?? 0.0;
    dateTime = args["dateTime"] ?? "";
  }
}
