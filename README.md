Object Detection App

 - Introduction

    This application is designed to help users detect and identify objects in real-time using their camera. It consists of three main modules: Home, Camera Detector, and Details.

  - How to Use

    Home Screen: Upon launching the app, you will be greeted by the Home screen. This screen features a search box, a list of objects, and a 'Start' button. The 'Start' button remains disabled until you select an object from the list. You can find your desired object by either scrolling through the list or using the search functionality.

    Camera Detector Screen: After selecting an object and clicking 'Get Started', you will navigate to the Camera Detection screen. Here, simply move your device around to allow the camera to scan for the selected object. You will also see a status box that provides real-time updates on what the application is detecting. Once the target object is detected, a 3-second countdown will initiate.

    Details Screen: Following the countdown, the app will direct you to the Details screen where you will see the captured image of the object along with some relevant information about it.

 - Technologies Used

    The application was developed using Flutter, leveraging several key dependencies:

    = GetX: An extra-light and powerful solution for state, navigation, and dependency management.
    = Camera: To integrate camera functionality for real-time object detection.
    = TFLite: Used for loading and running TensorFlow models on mobile devices.
    = Path Provider: To find commonly used locations on the filesystem.
    = Flutter ScreenUtil: For adapting screen and font sizes to various devices.

    I specifically chose these technologies and packages to ensure optimal performance and ease of use, focusing on real-time processing and compatibility across a wide range of devices.

  - Challenges Faced

    During development, the main challenges included:

    Dependency Compatibility: Ensuring that all packages worked harmoniously without conflicts was crucial. Finding the correct versions that fit together required meticulous attention to detail.
    Model Selection: Selecting an appropriate machine learning model that was efficient and accurate for our use case involved extensive research and testing.