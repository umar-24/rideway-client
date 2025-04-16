import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/features/auth/screen/forgot_password.dart';
import 'package:rideway/features/home/screen/home_screen.dart';
import 'package:rideway/widgets/my_textfeild.dart';
import 'package:rideway/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onPressed;
  const LoginScreen({super.key, required this.onPressed});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  late bool isObsecure;

  @override
  void initState() {
    super.initState();
    isObsecure = true;
  }

  //   void login(){
  //   setState(() {
  //     loading = true;
  //   });
  //   _auth.signInWithEmailAndPassword(
  //     email: emailController.text.toString(),
  //    password: passwordController.text.toString()).then((value){
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
  //     Toasts().toastMessages("SignIn Sucessful");
  //     setState(() {
  //       loading = false;
  //     });
  //    }).onError((error, StackTrace){
  //     Toasts().toastMessagesAlert(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //    });
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
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  "Enter your email address and password to get access to your account.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Column(
                  children: [
                    // Email field
                    MyTextFeild(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      prefixIcon: (Iconsax.send_2),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Password field
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
                        icon: isObsecure
                            ? const Icon(Iconsax.eye)
                            : const Icon(Iconsax.eye_slash),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Login Button
                RoundedButton(
                  title: "Login",
                  buttonColor: AppColors.primaryColor,
                  loading: loading,
                  onTap: () {
                  //  login();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HomePage()));
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
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