import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/widgets/my_textfeild.dart';
import 'package:rideway/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Add Firebase Auth import
import 'package:get/get.dart';  // Import Get package for snackbar

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  // Function to send password reset email
  void forgotPassword() {
  setState(() {
    loading = true;
  });

  _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
    // Replace Toasts with Get.snackbar for success message
    Get.snackbar(
      "Success",
      "Password reset email sent successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
    Navigator.pop(context);  // Close the current screen
    setState(() {
      loading = false;
    });
  }).onError((error, StackTrace) {
    // Replace Toasts with Get.snackbar for error message
    Get.snackbar(
      "Error",
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    setState(() {
      loading = false;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            MyTextFeild(
              controller: emailController,
              hintText: "Enter Email",
              obscureText: false,
              prefixIcon: Iconsax.direct_right,
            ),
            const SizedBox(height: 20),
            RoundedButton(
              title: "Forgot Password",
              buttonColor: AppColors.primaryColor,
              loading: loading,
              onTap: forgotPassword,  // Call the forgotPassword function on tap
            ),
          ],
        ),
      ),
    );
  }
}
