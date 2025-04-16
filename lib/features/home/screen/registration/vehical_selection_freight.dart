// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/widgets/build_options.dart';

class VehicalSelectionFreight extends StatefulWidget {
  const VehicalSelectionFreight({super.key});

  @override
  State<VehicalSelectionFreight> createState() => _VehicalSelectionFreightState();
}

class _VehicalSelectionFreightState extends State<VehicalSelectionFreight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Going to work as:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.containerBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  BuildOptions(
                    child: Image.asset("assets/images/car1.png"),
                    title: 'City driver',
                    subtitle: 'Drive passengers around the city',
                    onTap: () {
                      // Handle City driver selection
                    },
                  ),
                  Divider(),
                  BuildOptions(
                    child: Image.asset("assets/images/rickshaw.png"),
                    title: 'Rickshaw',
                    subtitle: 'Drive passengers around the city',
                    onTap: () {
                      // Handle City driver selection
                    },
                  ),
                  Divider(),
                  BuildOptions(
                    child: Image.asset("assets/images/bycicle.png"),
                    title: 'Moto',
                    subtitle: 'Drive passengers around the city',
                    onTap: () {
                      // Handle City driver selection
                    },
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