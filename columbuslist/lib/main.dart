// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/pages/profile_page.dart';
import 'package:columbuslist/pages/sell_page.dart';
import 'package:columbuslist/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/pages/signup_page.dart';
import 'package:columbuslist/pages/contact_page.dart';
import 'package:columbuslist/pages/main_layout.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/services/router.dart';
import 'package:columbuslist/services/locator.dart';

void main() async {
  setupLocator();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBOGSccf4DpIANbmBYgtGri14BchpX3nHQ",
          authDomain: "columbuslist-2ab77.firebaseapp.com",
          projectId: "columbuslist-2ab77",
          storageBucket: "columbuslist-2ab77.appspot.com",
          messagingSenderId: "508949398488",
          appId: "1:508949398488:web:252efd9e445b1ce4f828ad",
          measurementId: "G-ZELVFQ4EG2"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Columbus List',
      routes: {
        HomePage.route: (context) => HomePage(),
        LoginPage.route: (context) => LoginPage(),
        SignupPage.route: (context) => SignupPage(),
        ContactPage.route: (context) => ContactPage(),
        ProfilePage.route: (context) => ProfilePage(),
        SellPage.route: (context) => SellPage(),
        WishlistPage.route: (context) => WishlistPage(),
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Overlay(initialEntries: [
          OverlayEntry(builder: (context) => MainLayout(child: child))
        ]);
      },
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomePage.route,
    );
  }
}
