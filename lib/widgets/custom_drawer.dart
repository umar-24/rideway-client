// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/core/constants/images.dart';
import 'package:rideway/features/home/screen/driver_mode.dart';
import 'package:rideway/features/home/screen/home_screen.dart';
import 'package:rideway/features/home/screen/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // Drawer Header
          const SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: (){
                Get.to(ProfileScreen());
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Umar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Text("5", style: TextStyle(color: Colors.white),)
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 26),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(),
          // UserAccountsDrawerHeader(
          //   accountName: const Text(
          //     "Umar",
          //     style: TextStyle(color: Colors.white, fontSize: 18),
          //   ),
          //   accountEmail: Row(
          //     children: const [
          //       Icon(Icons.star, color: Colors.yellow, size: 16),
          //       Icon(Icons.star, color: Colors.yellow, size: 16),
          //       Icon(Icons.star, color: Colors.yellow, size: 16),
          //       Icon(Icons.star, color: Colors.yellow, size: 16),
          //       Icon(Icons.star_border, color: Colors.yellow, size: 16),
          //       SizedBox(width: 5),
          //       Text(
          //         "4 (1)",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ],
          //   ),
          //   currentAccountPicture: const CircleAvatar(
          //     backgroundColor: Colors.blue,
          //     child: Icon(
          //       Icons.person,
          //       color: Colors.white,
          //       size: 40,
          //     ),
          //   ),
          //   decoration: const BoxDecoration(
          //     color: Colors.black87,
          //   ),
          // ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.grey),
                  title: const Text(
                    "City",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Get.off(HomePage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.grey),
                  title: const Text(
                    "Request history",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.grey),
                  title: const Text(
                    "Couriers",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.directions, color: Colors.grey),
                  title: const Text(
                    "City to City",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.grey),
                  title: const Text(
                    "Freight",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.grey),
                  title: const Text(
                    "Notifications",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.grey),
                  title: const Text(
                    "Safety",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.grey),
                  title: const Text(
                    "Help",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.chat, color: Colors.grey),
                  title: const Text(
                    "Support",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.grey),
                  title: const Text(
                    "Online Registration",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          // Driver Mode Button and Social Icons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.off(DriverMode());
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
                      onTap: (){},
                      child: Container(
                        child: Image.asset(
                          AppImages.facebook,
                          width: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Image.asset(
                          AppImages.instagram,
                          width: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}