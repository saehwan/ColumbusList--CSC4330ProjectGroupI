// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHomePage();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Columbus List",
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Center(
                      child: Text(
                    "Login",
                  )),
                  onTap: () {
                    print("GO TO LOGIN PAGE");
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Center(
                      child: Text(
                    "Sign Up",
                  )),
                  onTap: () {
                    print("GO TO SIGN UP PAGE");
                  }),
            ),
          ],
          actionsIconTheme: IconThemeData(
            size: 32,
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Center(
                        child: Text(
                      "Home Page",
                      style: TextStyle(fontSize: 15),
                    )),
                    onTap: () {
                      print("GO TO SIGN UP PAGE");
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Center(
                        child: Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 15),
                    )),
                    onTap: () {
                      print("GO TO SIGN UP PAGE");
                    }),
              ),
            ],
          ),
        ),
        body: Container());
  }
}
