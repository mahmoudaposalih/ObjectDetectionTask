import 'package:farouk/modules/home/controller/home_controller.dart';
import 'package:farouk/modules/home/widgets/home_header.dart';
import 'package:farouk/modules/home/widgets/objects_list.dart';
import 'package:farouk/modules/home/widgets/start_button.dart';
import 'package:farouk/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(),
              controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.grey3,
                      ),
                    )
                  : ObjectsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: StartButton(),
    );
  }
}
