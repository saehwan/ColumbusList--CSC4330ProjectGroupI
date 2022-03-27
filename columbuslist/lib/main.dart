// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/pages/contact_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBOGSccf4DpIANbmBYgtGri14BchpX3nHQ",
          authDomain: "columbuslist-2ab77.firebaseapp.com",
          projectId: "columbuslist-2ab77",
          storageBucket: "columbuslist-2ab77.appspot.com",
          messagingSenderId: "508949398488",
          appId: "1:508949398488:web:252efd9e445b1ce4f828ad",
          measurementId: "G-ZELVFQ4EG2"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Columbus List',
      initialRoute: '/',
      routes: {
        HomePage.route: (context) => HomePage(),
        LoginPage.route: (context) => LoginPage(),
        ContactPage.route: (context) => ContactPage(),
      },
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return HomePage();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
