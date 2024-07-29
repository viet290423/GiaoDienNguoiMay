import 'package:demo/app/dimensions.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/screen/home/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendAccount extends StatelessWidget {
  final String userName;
  final List<Post> posts;

  const FriendAccount({super.key, required this.userName, required this.posts});

  @override
  Widget build(BuildContext context) {
    final List<Post> userPosts =
    posts.where((post) => post.name == userName).toList();

    final List<String> imagePaths = [
      'assets/images/labubu.webp',
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            children: [
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.back,
                                  size: Dimensions.iconSize24,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                        (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                              const Spacer(),
                              Container(
                                child: Row(
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
                              const Spacer(),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 20),
                  ],
                ),
                Positioned(
                  top: 260,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius30),
                              topRight: Radius.circular(Dimensions.radius30),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: const [
                                              Icon(Icons.chat, color: Colors.white),
                                              SizedBox(width: 5),
                                              Text('Chatting'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: const [
                                              Icon(Icons.person_remove, color: Colors.black),
                                              SizedBox(width: 5),
                                              Text('Unfriend'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text('Like', style: TextStyle(fontSize: 20, color: Colors.black)),
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
                                    Text('Post', style: TextStyle(fontSize: 20, color: Colors.black)),
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
                                    Text('Friends', style: TextStyle(fontSize: 20, color: Colors.black)),
                                    Text(
                                      '6',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6D9886),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: imagePaths.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                ),
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      imagePaths[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
