import 'package:farouk/modules/details/controller/details_controller.dart';
import 'package:farouk/modules/details/widgets/details.dart';
import 'package:farouk/modules/details/widgets/details_header.dart';
import 'package:farouk/modules/home/binding/home_binding.dart';
import 'package:farouk/modules/home/view/home_view.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:farouk/utilities/constants/app_strings.dart';
import 'package:farouk/utilities/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              DetailsHeader(),
              DetailsCard(
                file: controller.file,
                title: controller.title,
                confidence: controller.confidence,
                dateTime: controller.dateTime,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onPressed: () {
                  Get.offAll(HomeView(), binding: HomeBinding());
                },
                text: AppStrings.startOver,
                textColor: AppColors.white,
                color: AppColors.grey0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
