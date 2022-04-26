// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String route = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String genderValue = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: Center(
          child: Container(
            height: 600,
            width: 600,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(auth.currentUser!.email!.split("@").first.capitalize(),
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 210.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Name: ", style: TextStyle(fontSize: 20)),
                          Text("NAME", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text("Email: ", style: TextStyle(fontSize: 20)),
                          Text(auth.currentUser!.email!,
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text("Gender: ", style: TextStyle(fontSize: 20)),
                          DropdownButton(
                              value: genderValue,
                              items: <String>[
                                'Male',
                                'Female',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) => {
                                    setState(() {
                                      genderValue = newValue!;
                                    }),
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
