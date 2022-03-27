// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String route = "/contact";

  @override
  State<ContactPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
    );
  }
}
