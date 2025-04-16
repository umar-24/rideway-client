import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/features/home/screen/account_restoration_screen.dart';
import 'package:rideway/features/home/screen/home_screen.dart';
import 'package:rideway/widgets/custom_drawer.dart';

class DriverMode extends StatelessWidget {
  const DriverMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: AppColors.backgroundColor, // Dark background
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor2,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Green Info Card
            const SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Get income with us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Flexible hours',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: Colors.white),
                      SizedBox(width: 8),
                      Text('Your prices',
                          style: TextStyle(color: Colors.white,fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.percent, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Low service payments',
                          style: TextStyle(color: Colors.white,fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Driver Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                minimumSize: const Size(double.infinity, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset("assets/images/car1.png", height: 70,),
                  // Icon(Icons.directions_car, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
                    'Driver',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Courier Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                minimumSize: const Size(double.infinity, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset("assets/images/courier.png", height: 70,),
                  // Icon(Icons.delivery_dining, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
                    'Courier',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Bottom Buttons
            ElevatedButton(
              onPressed: () {
                Get.to(AccountRestorationScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("I already have an account"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.off(HomePage());
              },
              child: const Text(
                "Go to passenger mode",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
