import 'dart:async';
import 'package:demo/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../app/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  // Future<void> _loadResource() async {
  //   await Get.find<PopularProductController>().getPopularProductList();
  //   await Get.find<RecommendedProductController>().getRecommendedProductList();
  // }

  @override
  void initState() {
    super.initState();
    // _loadResource();
    controller =AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 2))..forward();
    
    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.linear);
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false
        ),
    );
  }

  // animation logo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/images/logo.png",
              width: Dimensions.spalshImg,
            )),
          ),
          Center(
              child: Image.asset(
            "assets/images/logo2.png",
            width: Dimensions.spalshImg,
          )),
        ],
      ),
    );
  }
}
