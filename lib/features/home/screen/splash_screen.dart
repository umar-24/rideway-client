import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/features/home/screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a delay for the splash screen
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the Home Screen after the delay
      Get.offAll(WelcomeScreen());
    });

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(AppImages.logoWhite)
      ),
    );
  }
}