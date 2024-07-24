import 'package:demo/app/dimensions.dart';
import 'package:demo/screen/setting_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
  ];

  // Hàm buildColumn với tham số màu sắc cho giá trị
  Column buildColumn(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: valueColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/flowers.png'),
                  ),
                  Text(
                    'TML VIET',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(

              padding: EdgeInsets.all(Dimensions.height10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildColumn('Like', '90', Color(0xFF6D9886)),
                  buildColumn('Post', '3', Color(0xFF6D9886)),
                  buildColumn('Friends', '6', Color(0xFF6D9886)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(imagePaths.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
