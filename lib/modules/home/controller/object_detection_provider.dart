import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ObjectDetectionProvider extends ChangeNotifier {
  final Set<String> _allObjects = {};
  List<String> _filteredObjects = [];
  bool _loading = true;
  final TextEditingController searchFieldController = TextEditingController();
  String selectedObject = '';

  ObjectDetectionProvider() {
    _initializeLabels();
    _setupSearchListener();
  }

  List<String> get filteredObjects => _filteredObjects;
  bool get isLoading => _loading;

  Future<void> _initializeLabels() async {
    final rawLabels = await rootBundle.loadString('assets/models/model.txt');
    _allObjects.addAll(
        rawLabels.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty));
    _filteredObjects = _allObjects.toList();
    _loading = false;
    notifyListeners();
  }

  void _setupSearchListener() {
    searchFieldController.addListener(() {
      _applySearchFilter(searchFieldController.text);
    });
  }

  void _applySearchFilter(String query) {
    _filteredObjects = query.isNotEmpty
        ? _allObjects
            .where((label) => label.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : _allObjects.toList();
    notifyListeners();
  }

  void pickObject(String objectName) {
    selectedObject = objectName;
    notifyListeners();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }
}
