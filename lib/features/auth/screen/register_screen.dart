// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/features/auth/screen/email_verify_screen.dart';
import 'package:rideway/widgets/my_textfeild.dart';
import 'package:rideway/widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterScreen({super.key, this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child(
    'User',
  );

  bool loading = false;
  late bool isObsecure;
  late bool isConfirmObsecure;
  bool isChecked = false;
  bool isCheckError = false;

  @override
  void initState() {
    super.initState();
    isObsecure = true;
    isConfirmObsecure = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void register() async {
    // Validate checkbox
    if (!isChecked) {
      setState(() {
        isCheckError = true;
      });
      Get.snackbar(
        "Required",
        "You must accept the Terms & Conditions",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      loading = true;
    });

    if (passwordController.text == confirmPasswordController.text) {
      try {
        // Create user with email and password
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        final userId = userCredential.user!.uid;
        //       // Get the user ID from the auth result
        await _database.child(userId).set({
          "name": nameController.text.toString(),
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
        });

        User? user = userCredential.user;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification(); // Send email verification

          Get.snackbar(
            "Email Sent",
            "Verification email sent. Please verify before continuing.",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
          );

          await _auth
              .signOut(); // Optional: sign out after sending verification

          Get.to(EmailVerifyScreen()); // Navigate to verification screen
        }
      } on FirebaseAuthException catch (error) {
        Get.snackbar(
          "Authentication Error",
          error.message ?? "Authentication error",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      Get.snackbar(
        "Error",
        "Passwords do not match!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      setState(() {
        loading = false;
      });
    }
  }

  // void register() async {
  //   setState(() {
  //     loading = true;
  //   });

  //   // Validate password match
  //   if (passwordController.text.toString() ==
  //       confirmPasswordController.text.toString()) {
  //     try {
  //       // Create user with email and password
  //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: emailController.text.toString(),
  //         password: passwordController.text.toString(),
  //       );

  //       // Show success message
  //       Toasts().toastMessages("Account Created");

  //       // Save user data to Realtime Database
  //       // final userId = userCredential.user!.uid;
  //       // Get the user ID from the auth result
  //     // await _database.child(userId).set({
  //     //   "first name": firstNameController.text.toString(),
  //     //   "last name": lastNameController.text.toString(),
  //     //   "email": emailController.text.toString(),
  //     //   "password": passwordController.text.toString()
  //     // });

  //       // Navigate to next screen
  //       Navigator.pushReplacement(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );

  //     } on FirebaseAuthException catch (error) {
  //       // Handle authentication errors
  //       Toasts().toastMessagesAlert(error.message ?? "Authentication error");
  //     } catch (e) {
  //       // Handle any other errors
  //       Toasts().toastMessagesAlert("An error occurred: $e");
  //     } finally {
  //       setState(() {
  //         loading = false;
  //       });
  //     }
  //   } else {
  //     // Password mismatch
  //     Toasts().toastMessagesAlert("Passwords do not match!");
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    height: screenHeight * 0.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Create Account!",
                  style: TextStyle(fontSize: 26, color: Colors.black),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  "Please enter valid information to access your account.",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: screenHeight * 0.03),
                Column(
                  children: [
                    MyTextFeild(
                      controller: nameController,
                      hintText: "Name",
                      obscureText: false,
                      prefixIcon: (Iconsax.user),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    // email
                    MyTextFeild(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      prefixIcon: (Iconsax.send_2),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // password
                    MyTextFeild(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: isObsecure,
                      prefixIcon: (Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon:
                            isObsecure
                                ? const Icon(Iconsax.eye)
                                : const Icon(Iconsax.eye_slash),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // confirm password
                    MyTextFeild(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: isConfirmObsecure,
                      prefixIcon: (Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmObsecure = !isConfirmObsecure;
                          });
                        },
                        icon:
                            isConfirmObsecure
                                ? const Icon(Iconsax.eye)
                                : const Icon(Iconsax.eye_slash),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),

                // Terms and Conditions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.primaryColor,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                              isCheckError = false; // clear error
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'By signing up, I agree to the ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to Terms & Conditions
                                        },
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to Privacy Policy
                                        },
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isCheckError)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 4),
                        child: Text(
                          "Please accept the terms and conditions",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),

                // Register Button
                RoundedButton(
                  title: "Register",
                  buttonColor: AppColors.primaryColor,
                  loading: loading,
                  onTap: () {
                    register();
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
