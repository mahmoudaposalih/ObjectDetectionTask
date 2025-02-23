import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farouk/utilities/constants/app_colors.dart';

class ExposureControlSlider extends StatelessWidget {
  const ExposureControlSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CameraObjectDetectionProvider, double>(
      selector: (_, provider) => provider.currentExposureOffset,
      builder: (context, currentExposure, _) {
        final provider = context.read<CameraObjectDetectionProvider>();

        return _RotatedSlider(
          value: currentExposure,
          min: provider.minAvailableExposureOffset,
          max: provider.maxAvailableExposureOffset,
          onChanged: provider.onCameraExposureChange,
        );
      },
    );
  }
}

class _RotatedSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _RotatedSlider({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        thumbColor: AppColors.grey5,
        activeColor: AppColors.grey3,
        value: value.clamp(min, max), // Ensures value is within range
        min: min,
        max: max,
        onChanged: onChanged,
      ),
    );
  }
}
