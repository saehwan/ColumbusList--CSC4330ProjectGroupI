// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const String route = "/signup";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    super.dispose();
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: Center(
          child: Container(
              height: 550,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 50.0, bottom: 30),
                      child: Text("SIGN UP",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        SizedBox(height: 12),
                        TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: 'Enter E-mail here',
                                border: OutlineInputBorder()),
                            onChanged: (text) {
                              refreshState();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        SizedBox(height: 12),
                        TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: 'Enter password here',
                                border: OutlineInputBorder()),
                            onChanged: (text) {
                              refreshState();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('SIGN UP', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 23, bottom: 23, left: 180, right: 180),
                        elevation: 10),
                    onPressed: () {
                      print('Pressed');
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(width: 5),
                      InkWell(
                        child:
                            Text("Login", style: TextStyle(color: Colors.blue)),
                        onTap: () => locator<NavigationService>()
                            .navigateTo(LoginPage.route),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}
