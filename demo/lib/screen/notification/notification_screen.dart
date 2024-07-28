import 'package:demo/app/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/app_bar_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:
          const AppBarWidget(icon: CupertinoIcons.bell, title: "Notification"),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height15),
                child: Text(
                  'Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: const Text(
                  'Lucas had sent you a Friend Request',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),

                subtitle: Padding(
                  padding: EdgeInsets.only(top: Dimensions.height10),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20 * 2),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black),
                        ),
                        child: const Text(
                          'Confirm',
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20 * 2),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Decline'),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: Text(
                  'Phúc has posted a new post',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '10p',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: Text(
                  'Phúc has commented on your post',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),

                subtitle: Text(
                  '10p',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
