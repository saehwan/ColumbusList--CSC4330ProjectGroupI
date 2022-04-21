// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  static const String route = "/sell";

  @override
  State<SellPage> createState() => SellPageState();
}

class SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, description, price, tags, images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 600,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Icon(Icons.person, size: 250),
                      SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Item Name",
                                border: InputBorder.none),
                            onSaved: (input) => name = input!,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Price",
                                border: InputBorder.none),
                            onSaved: (input) => name = input!,
                          )),
                      Container(
                        margin: EdgeInsets.all(8),
                        height: 7 * 24.0,
                        child: TextFormField(
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: "Description",
                            filled: true,
                            border: InputBorder.none,
                          ),
                          onSaved: (input) => price = input!,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                        top: 23, bottom: 23, left: 100, right: 100),
                    elevation: 10),
                onPressed: () => print("SELL"),
              ),
            ],
          ),
        ));
  }
}
