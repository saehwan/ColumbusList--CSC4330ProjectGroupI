// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  static const String route = "/wishlist";

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
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
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Wishlist",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
              SizedBox(height: 20),
              Container(
                  height: 150,
                  width: 800,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600)),
                  child: Row(
                    children: [Icon(Icons.person, size: 150)],
                  )),
            ],
          ),
        ));
  }
}
