import 'package:farouk/modules/home/controller/object_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:farouk/modules/camera/view/camera_view.dart';

import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/main_text.dart';

class ObjectDetectionButton extends StatelessWidget {
  const ObjectDetectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ObjectDetectionProvider, String>(
      selector: (context, provider) => provider.selectedObject,
      builder: (context, selectedObject, child) {
        bool isButtonActive = selectedObject.isNotEmpty;

        return FloatingActionButton.extended(
          onPressed: isButtonActive
              ? () => _navigateToCamera(context, selectedObject)
              : null,
          label: _buildButtonLabel(),
          backgroundColor: isButtonActive ? AppColors.black : AppColors.grey7,
        );
      },
    );
  }

  Widget _buildButtonLabel() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MainText(
          text: AppStrings.getStarted,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: 8.w),
        const Icon(Icons.arrow_forward, color: AppColors.white),
      ],
    );
  }

  void _navigateToCamera(BuildContext context, String selectedObject) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraView(title: selectedObject)),
    );
    context.read<ObjectDetectionProvider>().searchFieldController.clear();
  }
}
