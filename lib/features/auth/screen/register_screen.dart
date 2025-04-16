
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/widgets/my_textfeild.dart';
import 'package:rideway/widgets/rounded_button.dart';


class RegisterScreen extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterScreen({super.key, required this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final DatabaseReference _database =
  //     FirebaseDatabase.instance.ref().child('User');

  bool loading = false;
  late bool isObsecure;
  late bool isConfirmObsecure;

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
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
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
  //       final userId = userCredential.user!.uid;
  //       // Get the user ID from the auth result
  //     await _database.child(userId).set({
  //       "first name": firstNameController.text.toString(),
  //       "last name": lastNameController.text.toString(),
  //       "email": emailController.text.toString(),
  //       "password": passwordController.text.toString()
  //     });


  //       // Navigate to next screen
  //       Navigator.pushReplacement(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
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
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  "Please enter valid information to access your account.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Column(
                  children: [
                    Row(
                      children: [
                        // FIRST NAME
                        Expanded(
                          child: MyTextFeild(
                            controller: firstNameController,
                            hintText: "First Name",
                            obscureText: false,
                            prefixIcon: (Iconsax.user),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // LAST NAME
                        Expanded(
                          child: MyTextFeild(
                            controller: lastNameController,
                            hintText: "Last Name",
                            obscureText: false,
                            prefixIcon: (Iconsax.user),
                          ),
                        ),
                      ],
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
                        icon: isObsecure
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
                        icon: isConfirmObsecure
                            ? const Icon(Iconsax.eye)
                            : const Icon(Iconsax.eye_slash),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
                // Register Button
                RoundedButton(
                  title: "Register",
                  buttonColor: AppColors.primaryColor,
                  loading: loading,
                  onTap: () {
                    // register();
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
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
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