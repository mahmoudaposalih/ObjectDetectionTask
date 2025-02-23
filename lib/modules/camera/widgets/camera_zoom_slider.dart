import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farouk/utilities/constants/app_colors.dart';

class ZoomControlSlider extends StatelessWidget {
  const ZoomControlSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CameraObjectDetectionProvider, double>(
      selector: (_, provider) => provider.currentZoomLevel,
      builder: (context, currentZoom, _) {
        final provider = context.read<CameraObjectDetectionProvider>();

        return Slider(
          thumbColor: AppColors.grey5,
          activeColor: AppColors.grey3,
          value: currentZoom.clamp(
              provider.minAvailableZoom, provider.maxAvailableZoom),
          min: provider.minAvailableZoom,
          max: provider.maxAvailableZoom,
          divisions: 100,
          label: "${currentZoom.toStringAsFixed(1)}x",
          onChanged: provider.onCameraZoomChange,
        );
      },
    );
  }
}
