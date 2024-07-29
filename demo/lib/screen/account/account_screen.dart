import 'dart:convert';

import 'package:demo/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/controller/post_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/dimensions.dart';
import '../../models/post_model.dart';
import '../friends/friends_screen.dart';
import '../account/setting_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int friendCount = 0;

  @override
  void initState() {
    super.initState();
    _loadFriendCount();
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
                  const Text(
                    'labubu',
                    style: TextStyle(
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
                      Text('Like',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
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
                  Column(
                    children: [
                      const Text('Post',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      Consumer<PostController>(
                        builder: (context, postController, child) {
                          return Text(
                            '${postController.postCount}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6D9886),
                            ),
                          );
                        },
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
                            _loadFriendCount();
                          });
                        },
                        child: Column(
                          children: [
                            Text('Friends',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
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
              child: Consumer<PostController>(
                builder: (context, postController, child) {
                  return GridView.count(
                    crossAxisCount: 3,
                    children:
                        List.generate(postController.posts.length, (index) {
                      final post = postController.posts[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle tap event here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                startingIndex:
                                    index, // Pass the index to HomeScreen
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: post.decodedImage != null
                                ? Image(
                                    image: post.decodedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    post.image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
