import 'package:flutter/material.dart';

class RideOption extends StatelessWidget {
  final String imagePath;
  final String title;
  final String count;
  final double screenWidth;
  final bool selected;
  final VoidCallback onTap;

  const RideOption({
    super.key,
    required this.imagePath,
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
        width: screenWidth * 0.25,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: selected ? Colors.lightBlue : Colors.grey[850],
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
            Image.asset(
              imagePath,
              height: 50,
            ),
            SizedBox(height: screenWidth * 0.02),
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
                SizedBox(width: 5),
                Icon(
                  Icons.person,
                  color: Colors.grey[300],
                  size: 15,
                ),
                SizedBox(width: 5),
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
