import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/home/main_screen.dart';
import 'package:flutter/foundation.dart';
// import 'package:demo/screen/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:demo/screen/splash/splash_page.dart';
import 'package:demo/controller/post_controller.dart';


void main() {
  runApp(const MyApp());
}



// import 'package:device_preview/device_preview.dart';

// Future<void> main() async {
//   // Load .env file
//   await dotenv.load(fileName: ".env");
//
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostController()),
      ],
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Flutter Demo',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

