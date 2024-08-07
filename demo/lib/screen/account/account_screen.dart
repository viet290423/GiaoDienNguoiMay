import 'dart:convert';

import 'package:demo/screen/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
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
  String username = '';

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
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/labubu.webp',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.person,
                      size: Dimensions.iconSize24 + 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font26,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  iconSize: Dimensions.iconSize24,
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
            padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          // const SizedBox(height: 20),
          Expanded(
            child: Consumer<PostController>(
              builder: (context, postController, child) {
                return GridView.count(
                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
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
    );
  }
}
