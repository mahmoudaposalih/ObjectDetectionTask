import 'package:farouk/modules/camera/controller/camera_controller.dart';

import 'package:farouk/modules/home/controller/object_detection_provider.dart';
import 'package:farouk/modules/home/view/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjectDetectionProvider()),
        ChangeNotifierProvider(create: (_) => CameraObjectDetectionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Object Detection',
        home: ObjectDetectionScreen(),
      ),
    );
  }
}
