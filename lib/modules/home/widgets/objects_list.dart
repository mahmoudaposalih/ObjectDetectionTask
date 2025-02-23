import 'package:farouk/modules/home/controller/object_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_styles.dart';
import 'package:farouk/utilities/widgets/transparent_inkwell.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:farouk/utilities/widgets/no_data.dart';

class DetectedObjectsList extends StatelessWidget {
  const DetectedObjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<ObjectDetectionProvider, List<String>>(
        selector: (context, provider) => provider.filteredObjects,
        builder: (context, filteredObjects, child) {
          if (filteredObjects.isEmpty) {
            return _buildNoData();
          }
          return ListView.builder(
            itemCount: filteredObjects.length,
            itemBuilder: (context, index) {
              return _buildObjectTile(context, filteredObjects[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildObjectTile(BuildContext context, String objectName) {
    return Consumer<ObjectDetectionProvider>(
      builder: (context, provider, child) {
        bool isSelected = provider.selectedObject == objectName;

        return TransparentInkwell(
          onTap: () => provider.pickObject(objectName),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppStyles.borderRadius8,
              border: Border.all(
                color: isSelected ? AppColors.grey3 : AppColors.grey9,
              ),
            ),
            child: MainText(
              text: objectName,
              color: AppColors.grey1,
              fontSize: 16.sp,
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoData() {
    return const Center(child: NoData());
  }
}
