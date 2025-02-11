import 'package:advance_exam/screens/home_page.dart';
import 'package:advance_exam/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'SplashScreen',
    home: HomePage(),
    getPages: [
      GetPage(name: '/SplashScreen', page: () => SplashScreen()),
    ],
  ));
}