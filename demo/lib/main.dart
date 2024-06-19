import 'package:demo/auth/login.dart';
import 'package:demo/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// import 'package:device_preview/device_preview.dart';

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: const MainScreen(),
//     );
//   }
// }