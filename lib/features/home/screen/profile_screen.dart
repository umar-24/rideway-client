// ignore_for_file: sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/features/home/screen/registration/vehical_selection.dart';
import 'package:rideway/features/home/screen/registration/vehical_selection_courier.dart';
import 'package:rideway/features/home/screen/registration/vehical_selection_ctc.dart';
import 'package:rideway/features/home/screen/registration/vehical_selection_freight.dart';
import 'package:rideway/widgets/build_options.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String? userImage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If Google sign-in
      if (user.providerData.any((e) => e.providerId == 'google.com')) {
        setState(() {
          userName = user.displayName ?? 'Guest';
          userImage = user.photoURL;
        });
      } else {
        // Otherwise check from Realtime Database
        final uid = user.uid;
        final ref =
            FirebaseDatabase.instance.ref().child('User').child(uid);
        final snapshot = await ref.get();
        if (snapshot.exists) {
          final name = snapshot.child('name').value;
          setState(() {
            userName = name?.toString() ?? 'Guest';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(userName, style: const TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: userImage != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(userImage!),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How do you want to get\nincome with us?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  BuildOptions(
                    child: Icon(Icons.directions_car),
                    title: 'City driver',
                    subtitle: 'Drive passengers around the city',
                    onTap: () => Get.to(VehicalSelection()),
                  ),
                  SizedBox(height: 20),
                  BuildOptions(
                    child: Icon(Icons.local_shipping_outlined),
                    title: 'Courier',
                    subtitle: 'Deliver packages up to 20kg within the city',
                    onTap: () => Get.to(VehicalSelectionCourier()),
                  ),
                  SizedBox(height: 20),
                  BuildOptions(
                    child: Icon(Icons.alt_route),
                    title: 'City to City driver',
                    subtitle: 'Transport passengers between cities',
                    onTap: () => Get.to(VehicalSelectionCtc()),
                  ),
                  SizedBox(height: 20),
                  BuildOptions(
                    child: Icon(Icons.directions_car),
                    title: 'Freight driver',
                    subtitle: 'Deliver cargoes over 20kg',
                    onTap: () => Get.to(VehicalSelectionFreight()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Faisalabad',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Change the city',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
                        child: Icon(
                          Iconsax.location,
                          color: Colors.green.shade900,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
