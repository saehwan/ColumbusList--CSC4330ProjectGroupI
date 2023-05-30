// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:columbuslist/variables.dart';

class WishlistItem {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List? tags;
  final String? image;
  final String? contact;

  WishlistItem(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.tags,
      this.image,
      this.contact});
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  static const String route = "/wishlist";

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _formKey = GlobalKey<FormState>();

  List wishlistedItems = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    wishlistedItems.clear();
    List ids = [];
    await usercollection.doc(auth.currentUser!.uid).get().then(((value) => {
          for (int i = 0; i < value['wishlist'].length; i++)
            {ids.add(value['wishlist'][i])}
        }));
    List tempList = [];
    for (int i = 0; i < ids.length; i++) {
      var wishlistObject = [ids[i]];
      await itemcollection
          .doc(ids[i])
          .get()
          .then((value) => {
                if (value['contact'] != auth.currentUser!.email)
                  {
                    tempList.add(WishlistItem(
                      id: ids[i],
                      name: value['name'],
                      description: value['description'],
                      price: value['price'],
                      tags: value['tags'],
                      image: value['image'],
                      contact: value['contact'],
                    )),
                  }
                else
                  {
                    usercollection.doc(auth.currentUser!.uid).update({
                      'wishlist': FieldValue.arrayRemove(wishlistObject),
                    }),
                  }
              })
          .catchError((e) => {
                if (e.toString().contains("does not exist"))
                  {
                    usercollection.doc(auth.currentUser!.uid).update({
                      'wishlist': FieldValue.arrayRemove(wishlistObject),
                    }),
                    setState(() {}),
                  }
              });
    }
    wishlistedItems = tempList;
    setState(() {});
  }

  void removeFromWishlist(String id) {
    var wishlistObject = [id];
    usercollection.doc(auth.currentUser!.uid).update({
      'wishlist': FieldValue.arrayRemove(wishlistObject),
    });
    setState(() {});
    getData();
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

                    return Flexible(
                      child: ListView.builder(
                          itemCount: wishlistedItems.length,
                          itemBuilder: (context, index) {
                            var wishlistedItem = wishlistedItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 500.0, right: 500, bottom: 20),
                              child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600)),
                                  child: Row(
                                    children: [
                                      Image(
                                          image: NetworkImage(
                                            wishlistedItem.image,
                                          ),
                                          width: 250),
                                      SizedBox(width: 100),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(wishlistedItem.name,
                                              style: TextStyle(fontSize: 25)),
                                          Text(wishlistedItem.description),
                                          Text("\$" +
                                              wishlistedItem.price.toString()),
                                          Text(wishlistedItem.contact
                                              .toString()),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            child: Text('Remove from wishlist',
                                                style: TextStyle(fontSize: 12)),
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.only(
                                                    top: 13,
                                                    bottom: 13,
                                                    left: 30,
                                                    right: 30),
                                                elevation: 10),
                                            onPressed: () {
                                              removeFromWishlist(
                                                  wishlistedItem.id);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    );
                  }),
            ],
          ),
        ));
  }
}
