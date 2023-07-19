import 'package:flutter_example_pages/view/page/welcome/splash.dart';
import 'package:get/get.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
