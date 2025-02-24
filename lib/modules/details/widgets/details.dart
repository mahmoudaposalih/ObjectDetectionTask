import 'dart:io';

import 'package:camera/camera.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';

import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObjectInfoCard extends StatelessWidget {
  final XFile? file;
  final String title;
  final double confidence;
  final String dateTime;

  const ObjectInfoCard({
    super.key,
    required this.file,
    required this.title,
    required this.confidence,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.grey9,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey9,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.file(
              File(file!.path),
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _buildInfoRow(AppStrings.recognizedObject, title)),
              SizedBox(width: 5,),
              Expanded(
                child: _buildInfoRow(AppStrings.confidence,
                    '${(confidence * 100).toStringAsFixed(2)}%'),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(child: _buildInfoRow(AppStrings.date, dateTime.toString().substring(0, 10))),
              SizedBox(width: 5,),
              Expanded(child: _buildInfoRow(AppStrings.time, dateTime.toString().substring(11, 19))),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(text: label, fontSize: 16.sp, fontWeight: FontWeight.w500 , color: AppColors.blueDark,),
          MainText(text: value, fontSize: 16.sp, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
