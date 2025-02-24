import 'package:camera/camera.dart';
import 'package:farouk/modules/details/widgets/details.dart';
import 'package:farouk/modules/details/widgets/details_header.dart';

import 'package:farouk/modules/home/view/home_view.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final XFile? file;
  final String title;
  final double confidence;
  final String dateTime;

  const DetailsScreen({
    super.key,
    required this.file,
    required this.confidence,
    required this.dateTime,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderSection(), // Updated header name
                SizedBox(height: 16.h),
                ObjectInfoCard(
                  file: file,
                  title: title,
                  confidence: confidence,
                  dateTime: dateTime,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjectDetectionScreen()),
                      (route) => false,
                    );
                  },
                  text: AppStrings.startOver,
                  textColor: AppColors.white,
                  //color: AppColors.blueDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
