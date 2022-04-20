// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/signup_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;

  void refreshState() {
    setState(() {});
  }

  login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((signedUser) {
        return {
          locator<NavigationService>().navigateTo(HomePage.route),
        };
      });
    }
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 50.0, bottom: 30),
                        child: Text("LOGIN",
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter e-mail here",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onSaved: (input) => email = input!,
                          ),
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter password here",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onSaved: (input) => password = input!,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('LOGIN', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 23, bottom: 23, left: 180, right: 180),
                          elevation: 10),
                      onPressed: login,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 5),
                        InkWell(
                          child: Text("Sign Up",
                              style: TextStyle(color: Colors.blue)),
                          onTap: () => locator<NavigationService>()
                              .navigateTo(SignupPage.route),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
