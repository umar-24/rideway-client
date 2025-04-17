import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rideway/core/constants/colors.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Support", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppColors.containerBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.call, color: Colors.white, size: 50),
                                  Text(
                                    "Call Support",
                                    style: TextStyle(color: Colors.white, fontSize: 35),
                                  ),
                                ],
                              ),
                            ),
                          ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppColors.containerBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.direct, color: Colors.white, size: 50),
                                  Text(
                                    "Email",
                                    style: TextStyle(color: Colors.white, fontSize: 35),
                                  ),
                                ],
                              ),
                            ),
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}