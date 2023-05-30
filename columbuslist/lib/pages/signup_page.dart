// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/pages/signup_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const String route = "/signup";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? email, password, confirmPassword;

  register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((signedUser) {
        usercollection.doc(signedUser.user!.uid).set({
          'contact': {
            'name': '',
            'email': email!.toLowerCase(),
          },
          'wishlist': [],
          'notifyChange': false,
        });
        auth.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
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
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                            ),
                            validator: (input) =>
                                !input!.contains('@columbus.edu')
                                    ? 'E-mail must end with @columbus.edu'
                                    : null,
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
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                            ),
                            validator: (input) => input!.length < 6
                                ? 'Password must be at least 6 characters'
                                : null,
                            onSaved: (input) => password = input!,
                            obscureText: true,
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
                          Text("Confirm Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                          SizedBox(height: 12),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Re-enter your password",
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
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                            ),
                            validator: (input) => confirmPassword == password
                                ? null
                                : 'Passwords must match',
                            onSaved: (input) => confirmPassword = input!,
                            obscureText: true,
                          ),
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
                      onPressed: register,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(width: 5),
                        InkWell(
                          child: Text("Login",
                              style: TextStyle(color: Colors.blue)),
                          onTap: () => locator<NavigationService>()
                              .navigateTo(LoginPage.route),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
