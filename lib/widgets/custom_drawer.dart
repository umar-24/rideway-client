// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/features/home/screen/driver_mode.dart';
import 'package:rideway/features/home/screen/home_screen.dart';
import 'package:rideway/features/home/screen/profile_screen.dart';
import 'package:rideway/features/home/screen/registration/registration_screen.dart';
import 'package:rideway/features/home/screen/safety_screen.dart';
import 'package:rideway/features/home/screen/setting_screen.dart';
import 'package:rideway/features/home/screen/support_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? userName;
  String? photoURL;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref()
          .child('User')
          .child(user.uid);

      final snapshot = await ref.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map;
        setState(() {
          userName = data['name'] ?? user.displayName ?? "User";
          photoURL = data['photoUrl'] ?? user.photoURL;
          isLoading = false;
        });
      } else {
        // Fallback to Firebase Auth (Google login)
        setState(() {
          userName = user.displayName ?? "User";
          photoURL = user.photoURL;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        userName = "Guest";
        isLoading = false;
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 60),
          isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ProfileScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        photoURL != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(photoURL!),
                                radius: 25,
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 25,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName ?? "Guest",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Text("5", style: TextStyle(color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 26),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          const Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.grey),
                  title: const Text("City", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.off(const HomePage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.grey),
                  title:
                      const Text("Request history", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.grey),
                  title: const Text("Couriers", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.directions, color: Colors.grey),
                  title: const Text("City to City", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.grey),
                  title: const Text("Freight", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.grey),
                  title:
                      const Text("Notifications", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.grey),
                  title: const Text("Safety", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.to(const SafetyScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: const Text("Settings", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.to(const SettingsScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.grey),
                  title: const Text("Help", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.chat, color: Colors.grey),
                  title: const Text("Support", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.to(const SupportScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.grey),
                  title:
                      const Text("Online Registration", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.to(DriverRegistrationScreen());
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.off(const DriverMode());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "DRIVER MODE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.facebook,
                        width: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.instagram,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
