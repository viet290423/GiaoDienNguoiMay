import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/screen/account/setting_screen.dart';
import '../friends/friends_screen.dart';
import '../../app/dimensions.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int friendCount = 0;
  String username = '';

  final List<String> imagePaths = [
    'assets/images/anh1.jpg',
    'assets/images/labubu1.webp',
    'assets/images/labubu2.webp',
    'assets/images/labubu3.jpg',
    'assets/images/labubu4.webp',
    'assets/images/labubu5.webp',
    'assets/images/labubu6.webp',
    'assets/images/labubu7.jpg',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
    'assets/images/anh1.jpg',
    'assets/images/flowers.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadFriendCount();
    _loadUsername();
  }

  Future<void> _loadFriendCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String? temporaryFriendsJson = prefs.getString('temporary_friends');

    if (temporaryFriendsJson != null && temporaryFriendsJson.isNotEmpty) {
      final List<dynamic> friendsList = jsonDecode(temporaryFriendsJson);
      setState(() {
        friendCount = friendsList.length;
      });
    } else {
      setState(() {
        friendCount = 0;
      });
    }
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Username';
    });
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
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/flowers.png'),
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: 40,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      Text('Like', style: TextStyle(color: Colors.black, fontSize: 20)),
                      Text(
                        '90',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D9886),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Text('Post', style: TextStyle(color: Colors.black,fontSize: 20)),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D9886),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendsPage()),
                          ).then((_) {
                            _loadFriendCount(); // Cập nhật số lượng bạn bè khi trở lại
                          });
                        },
                        child: Column(
                          children: [
                            Text('Friends', style: TextStyle(color: Colors.black, fontSize: 20)),
                            Text(
                              '$friendCount',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6D9886),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(imagePaths.length, (index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
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
