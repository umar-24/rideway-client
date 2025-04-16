import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rideway/core/constants/colors.dart';
import 'package:rideway/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> rideOptions = [
    {
      "image": "assets/images/accar.png",
      "title": "Ride A/C",
      "count": "4",
    },
    {
      "image": "assets/images/bycicle.png",
      "title": "MOTO",
      "count": "1",
    },
    {
      "image": "assets/images/car1.png",
      "title": "Ride Mini",
      "count": "4",
    },
    {
      "image": "assets/images/rickshaw.png",
      "title": "Auto",
      "count": "3",
    },
    {
      "image": "assets/images/signaling.png",
      "title": "City to city",
      "count": "4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              // Real Map using flutter_map
              SizedBox(
                height: screenHeight * 0.65,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(31.5204, 74.3587),
                    // zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(31.5204, 74.3587),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Top Left Menu Button
              Positioned(
                top: screenHeight * 0.05,
                left: screenWidth * 0.03,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(Icons.menu, color: Colors.black),
                ),
              ),
              // Bottom Right My Location Button
              Positioned(
                bottom: screenHeight * 0.01,
                right: screenWidth * 0.03,
                child: FloatingActionButton(
                  heroTag: "profile button",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.my_location, color: Colors.black),
                ),
              ),
              // Bottom Sheet
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Ride Options
                          SizedBox(
                            height: screenHeight * 0.12,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: rideOptions.length,
                              itemBuilder: (context, index) {
                                var option = rideOptions[index];
                                return RideOption(
                                  imagePath: option['image'],
                                  icon: option['icon'],
                                  title: option['title'],
                                  count: option['count'],
                                  screenWidth: screenWidth,
                                  selected: selectedIndex == index,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          // Input Fields
                          // InputField(
                          //   icon: Icons.location_on,
                          //   hint: 'Paragon birds (Gobindpura)',
                          //   screenWidth: screenWidth,
                          // ),
                          SizedBox(height: screenHeight * 0.015),
                          InputField(
                            icon: Icons.search,
                            hint: 'Street No 19',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          InputField(
                            icon: Icons.monetization_on,
                            hint: 'PKR Offer your fare',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          // Find a Driver Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Find a driver',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Ride Option Widget
class RideOption extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;
  final String title;
  final String count;
  final double screenWidth;
  final bool selected;
  final VoidCallback onTap;

  const RideOption({
    super.key,
    this.imagePath,
    this.icon,
    required this.title,
    required this.count,
    required this.screenWidth,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.26,
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, height: 50)
            else if (icon != null)
              Icon(icon, color: Colors.white, size: screenWidth * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(Icons.person, color: Colors.grey[300], size: 15),
                const SizedBox(width: 5),
                Text(
                  count,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: screenWidth * 0.03,
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

// Input Field Widget
class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final double screenWidth;

  const InputField({
    super.key,
    required this.icon,
    required this.hint,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: screenWidth * 0.06,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.03,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: screenWidth * 0.04,
      ),
    );
  }
}


