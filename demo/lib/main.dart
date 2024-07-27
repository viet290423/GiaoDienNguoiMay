import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/home/main_screen.dart';
import 'package:flutter/foundation.dart';
// import 'package:demo/screen/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       // home: MainScreen(),
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }


import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  // Load .env file
  await dotenv.load(fileName: ".env");

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}