import 'package:farouk/modules/home/controller/object_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farouk/modules/home/widgets/home_header.dart';
import 'package:farouk/modules/home/widgets/objects_list.dart';
import 'package:farouk/modules/home/widgets/start_button.dart';
import 'package:farouk/utilities/constants/app_colors.dart';

class ObjectDetectionScreen extends StatelessWidget {
  const ObjectDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: _buildContent(),
        floatingActionButton: const ObjectDetectionButton(),
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<ObjectDetectionProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ObjectDetectionHeader(),
            provider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.grey3,
                    ),
                  )
                : const DetectedObjectsList(),
          ],
        );
      },
    );
  }
}
