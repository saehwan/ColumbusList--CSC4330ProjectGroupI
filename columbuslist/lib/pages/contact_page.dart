// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String route = "/contact";

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, message;

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("SUBMITTED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: Center(
          child: Container(
            height: 600,
            width: 1200,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("Contact",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                  Text("Contact Us Here"),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Name",
                            border: InputBorder.none),
                        onSaved: (input) => name = input!,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "E-mail",
                            border: InputBorder.none),
                        onSaved: (input) => email = input!,
                      )),
                  Container(
                    margin: EdgeInsets.all(8),
                    height: 7 * 24.0,
                    child: TextFormField(
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Enter a message",
                        filled: true,
                        border: InputBorder.none,
                      ),
                      onSaved: (input) => message = input!,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 23, bottom: 23, left: 250, right: 250),
                        elevation: 10),
                    onPressed: submit,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
