// ignore_for_file: sort_child_properties_last, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:rideway/features/home/screen/update_phome_screen.dart';
import 'package:rideway/features/home/screen/welcome_screen.dart';
import 'package:rideway/widgets/custom_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  void showDeleteConfirmation() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[850],  // Dark background color
        title: const Text(
          "Are you sure?",
          style: TextStyle(
            color: Colors.white, // Title text color
            fontSize: 18, 
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Do you really want to delete your account? This action cannot be undone.",
          style: TextStyle(color: Colors.white70), // Content text color
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),  // Rounded corners for the dialog
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),  // Button text color
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[700],  // Button background color
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),  // Rounded corners for the button
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();  // Close the dialog
            },
          ),
          TextButton(
            child:  Text(
              "Delete",
              style: TextStyle(color: Colors.white),  // Delete button text color
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,  // Button background color
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),  // Rounded corners for the button
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();  // Close the dialog
              await deleteUserAccount();  // Delete account function
            },
          ),
        ],
      );
    },
  );
}


  // Function to delete user account
  Future<void> deleteUserAccount() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Deleting user data from Realtime Database
        DatabaseReference userRef = _database.ref().child('User').child(user.uid);
        await userRef.remove();

        // Deleting user from Firebase Authentication
        if (user.providerData[0].providerId == 'google.com') {
          // Google sign-in, delete from Firebase Authentication
          await Get.offAll(WelcomeScreen());
        } else {
          // Email/Password sign-in, delete from Firebase Authentication
          await user.delete();
        }

        // After successful deletion, log the user out and navigate to the WelcomeScreen
        await _auth.signOut();
        Get.offAll(WelcomeScreen()); // Navigate to the WelcomeScreen
      }
    } catch (e) {
      // Handle errors (e.g., user deletion failure)
      print("Error deleting account: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("There was an error deleting your account. Please try again."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();  // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showLogoutConfirmation() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[850],  // Dark background color
        title: const Text(
          "Log out",
          style: TextStyle(
            color: Colors.white,  // Title text color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure you want to log out? You will need to log in again to access your account.",
          style: TextStyle(color: Colors.white70), // Content text color
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),  // Rounded corners for the dialog
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),  // Button text color
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[700],  // Button background color
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),  // Rounded corners for the button
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();  // Close the dialog
            },
          ),
          TextButton(
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.white),  // Log out button text color
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,  // Button background color
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),  // Rounded corners for the button
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();  // Close the dialog
              await logOut();  // Log out function
            },
          ),
        ],
      );
    },
  );
}

Future<void> logOut() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();  // Sign out from Firebase
      Get.offAll(WelcomeScreen());  // Navigate to the welcome screen
    }
  } catch (e) {
    print("Error logging out: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance;
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1C1C1C),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingItem(
              title: 'Phone number',
              subtitle: phoneNumber,
              showArrow: true,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => UpdatePhoneScreen(initialPhone: phoneNumber),
                  ),
                );

                if (result != null) {
                  setState(() {
                    phoneNumber = result;
                  });
                }
              },
            ),
            settingItem(
              title: 'Language',
              subtitle: 'Default language',
              showArrow: true,
            ),
            settingItem(title: 'Date and distances', showArrow: true),
            // settingItem(title: 'Night mode', subtitle: 'System', showArrow: true),
            settingItem(title: 'Navigation', showArrow: true),
            settingItem(title: 'Rules and terms', showArrow: true),
            settingItem(
              title: 'Log out',
              onTap: () {
                showLogoutConfirmation();  // Show log out confirmation dialog
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                showDeleteConfirmation();  // Show delete confirmation dialog
              },
              child: Text(
                'Delete account',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingItem({
    required String title,
    String? subtitle,
    bool showArrow = false,
    void Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          subtitle:
              subtitle != null
                  ? Text(subtitle, style: const TextStyle(color: Colors.grey))
                  : null,
          trailing:
              showArrow
                  ? const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  )
                  : null,
          onTap: onTap,
        ),
        const Divider(color: Colors.grey, height: 1),
      ],
    );
  }
}
