import 'package:demo/app/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title;
  const AppBarWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: Dimensions.iconSize24,
                color: Colors.black,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.font20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(500, 53);
}
