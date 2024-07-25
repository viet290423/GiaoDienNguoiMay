import 'package:demo/app/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/app_bar_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:
          const AppBarWidget(icon: Icons.notifications, title: "Notification"),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: const Text('Lucas had sent you a Friend Request'),
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
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: Dimensions.font20),
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
                  ),
                ),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: Text('Phúc has post a new post'),
                subtitle: Text('10p'),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/flowers.png'),
                  radius: 20,
                ),
                title: Text('Phúc has comment your post'),
                subtitle: Text('10p'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
