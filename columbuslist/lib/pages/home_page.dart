// ignore_for_file: prefer_const_constructors

import 'package:columbuslist/pages/contact_page.dart';
import 'package:columbuslist/pages/login_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = "/home";

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Columbus List",
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 51, 91, 100),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Center(
                      child: Text(
                    "Login",
                  )),
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginPage.route);
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
                      Navigator.of(context).pushNamed(ContactPage.route);
                    }),
              ),
            ],
          ),
        ),
        body: Container());
  }
}
