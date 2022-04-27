// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:columbuslist/variables.dart';

class WishlistItem {
  final String? name;
  final String? description;
  final int? price;
  final List? tags;
  final List? images;

  WishlistItem({
    this.name,
    this.description,
    this.price,
    this.tags,
    this.images,
  });
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  static const String route = "/wishlist";

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, message;

  List wishlistedItems = [];

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("SUBMITTED");
    }
  }

  Future getData(List ids) async {
    for (int i = 0; i < ids.length; i++) {
      var result = await itemcollection.doc(ids[i]).get().then((value) => {
            wishlistedItems.add(WishlistItem(
                name: value['name'],
                description: value['description'],
                price: value['price'],
                tags: value['tags'],
                images: value['images']))
          });
      return result;
    }
    return;
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
              StreamBuilder(
                  stream: usercollection
                      .doc(auth.currentUser!.uid)
                      .get()
                      .asStream(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return FutureBuilder(
                        future: getData(snapshot.data!.data()['wishlist']),
                        builder: (context, AsyncSnapshot snapshott) {
                          if (snapshott.hasData) {
                            return Flexible(
                              child: ListView.builder(
                                  itemCount: wishlistedItems.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: 150,
                                        width: 600,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade600)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person, size: 150),
                                            Text(wishlistedItems[index].name),
                                          ],
                                        ));
                                  }),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  }),
            ],
          ),
        ));
  }
}
