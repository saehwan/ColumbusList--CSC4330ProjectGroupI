// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:columbuslist/pages/sell_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = "/home";

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  String searchText = "";
  bool isLoggedIn = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
  }

  void refreshState() {
    setState(() {});
  }

  void sell() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: Column(
          children: [
            IntrinsicHeight(
              child: Stack(
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: searchController.text.isNotEmpty
                                      ? GestureDetector(
                                          child: Icon(Icons.clear),
                                          onTap: () {
                                            searchController.clear();
                                            refreshState();
                                          },
                                        )
                                      : Text(""),
                                  hintText: 'Search...',
                                  border: InputBorder.none),
                              onChanged: (text) {
                                refreshState();
                              }),
                        ),
                      ),
                    ),
                  ),
                  isLoggedIn == true
                      ? Positioned(
                          top: 15,
                          right: 5,
                          child: ElevatedButton(
                            child: Text('Sell an item',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(
                                    top: 13, bottom: 13, left: 80, right: 80),
                                elevation: 10),
                            onPressed: () {
                              locator<NavigationService>()
                                  .navigateTo(SellPage.route);
                            },
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
            StreamBuilder(
                stream: itemcollection.get().asStream(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext ctx, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => print("Here"),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                          image:
                                              NetworkImage(doc["images"][0])),
                                      Text(doc["name"],
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 5),
                                      Text(doc["description"]),
                                      SizedBox(height: 5),
                                      Text(doc["price"].toString()),
                                      SizedBox(height: 5),
                                      Text("Tags: " +
                                          doc["tags"]
                                              .toString()
                                              .replaceAll("[", "")
                                              .replaceAll("]", ""))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
          ],
        ));
  }
}
