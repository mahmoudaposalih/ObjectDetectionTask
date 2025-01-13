import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> objects = <String>[].obs;
  RxList<String> filteredObjects = <String>[].obs;
  Rx<bool> isLoading = true.obs;
  TextEditingController searchController = TextEditingController();
  Rx<String> selectedObject = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadLabels();
    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });
  }

  Future<void> loadLabels() async {
    final labels = await rootBundle.loadString('assets/models/model.txt');
    objects.value =
        labels.split('\n').where((label) => label.isNotEmpty).toList();
    filteredObjects.value = List.from(objects);
    isLoading.value = false;
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> tempSearchList = objects.where((item) {
        return item.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredObjects.value = tempSearchList;
    } else {
      filteredObjects.value = List.from(objects);
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
