import 'package:farouk/modules/camera/controller/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/widgets/main_text.dart';

class CaptureCounter extends StatelessWidget {
  const CaptureCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CameraObjectDetectionProvider, int>(
      selector: (_, provider) => provider.countdown,
      builder: (context, countdown, _) {
        return Visibility(
          visible: countdown < 3,
          child: Center(
            child: MainText(
              text: countdown > 0 ? '$countdown' : '',
              fontSize: 70.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        );
      },
    );
  }
}
