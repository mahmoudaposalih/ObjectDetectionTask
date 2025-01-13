import 'dart:io';

import 'package:camera/camera.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/constants/app_styles.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsCard extends StatelessWidget {
  final XFile? file;
  final String title;
  final double confidence;
  final String dateTime;

  const DetailsCard({
    super.key,
    required this.file,
    required this.title,
    required this.confidence,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.grey9,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.borderRadius12,
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: AppStyles.borderRadius8,
              child:
                  Image.file(File(file!.path), height: 300, fit: BoxFit.cover),
            ),
            ListTile(
              title: MainText(text: AppStrings.recognizedObject),
              trailing: MainText(text: title),
            ),
            Divider(height: 0),
            ListTile(
              title: MainText(text: AppStrings.confidence),
              trailing:
                  MainText(text: '${(confidence * 100).toStringAsFixed(2)}%'),
            ),
            Divider(height: 0),
            ListTile(
              title: MainText(text: AppStrings.date),
              trailing: MainText(
                text: dateTime.toString().substring(0, 10),
              ),
            ),
            Divider(height: 0),
            ListTile(
              title: MainText(text: AppStrings.time),
              trailing: MainText(
                text: dateTime.toString().substring(11, 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
