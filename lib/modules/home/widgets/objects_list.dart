import 'package:farouk/modules/home/controller/home_controller.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_styles.dart';
import 'package:farouk/utilities/widgets/custom_transparent_inkwell.dart';
import 'package:farouk/utilities/widgets/main_text.dart';
import 'package:farouk/utilities/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ObjectsList extends StatelessWidget {
  const ObjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return Expanded(
      child: Obx(() {
        if (controller.filteredObjects.isEmpty) {
          return Center(child: NoData());
        } else {
          return ListView.builder(
            itemCount: controller.filteredObjects.length,
            itemBuilder: (context, index) {
              return CustomTransparentInkwell(
                  onTap: () {
                    controller.selectedObject.value =
                        controller.filteredObjects[index];
                  },
                  child: Obx(
                    () => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppStyles.borderRadius8,
                        border: Border.all(
                          color: controller.selectedObject.value ==
                                  controller.filteredObjects[index]
                              ? AppColors.grey3
                              : AppColors.grey9,
                        ),
                      ),
                      child: MainText(
                        text: controller.filteredObjects[index],
                        color: AppColors.grey1,
                        fontSize: 16.sp,
                      ),
                    ),
                  ));
            },
          );
        }
      }),
    );
  }
}
