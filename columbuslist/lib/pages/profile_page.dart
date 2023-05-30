// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String route = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _textController = TextEditingController();
  String genderValue = "Male";

  List<bool> displaySettings = [];
  bool displayEdit = false;

  void editItem(String id, String price, int index) {
    itemcollection.doc(id).update({
      'price': double.parse(price),
    }).then(
      (value) => setState(() {
        displaySettings[index] = false;
        displayEdit = false;
        _textController.text = "";
      }),
    );
    usercollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['wishlist'].contains(id)) {
          usercollection.doc(doc.id).update({
            'notifyChange': true,
          });
        }
      });
    });
  }

  void removeItem(String id) {
    itemcollection.doc(id).delete();
  }

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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 210.0),
                      child: Column(
                        children: [
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
                                  items: <String>['Male', 'Female', 'Other']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                          Padding(
                            padding: const EdgeInsets.only(right: 210.0),
                            child: Text("My Items",
                                style: TextStyle(fontSize: 30)),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                        stream: itemcollection
                            .where("contact",
                                isEqualTo: auth.currentUser!.email)
                            .get()
                            .asStream(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return SizedBox(
                            height: 300,
                            width: 600,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 300,
                                  maxCrossAxisExtent: 300,
                                ),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data!.docs[index];

                                  displaySettings.add(false);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: displaySettings[index] == false
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: InkWell(
                                                          onTap: () => setState(
                                                                () {
                                                                  displayEdit =
                                                                      false;
                                                                  displaySettings[
                                                                          index] =
                                                                      true;
                                                                },
                                                              ),
                                                          child: Icon(
                                                              Icons.settings)),
                                                    )),
                                                Image(
                                                    image: NetworkImage(
                                                      doc["image"],
                                                    ),
                                                    height: 150),
                                                Text(doc["name"],
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                SizedBox(height: 5),
                                                Text(doc["description"]),
                                                SizedBox(height: 5),
                                                Text("\$" +
                                                    doc["price"].toString()),
                                                SizedBox(height: 5),
                                                Text("Tags: " +
                                                    doc["tags"]
                                                        .toString()
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "")),
                                                SizedBox(height: 10),
                                              ],
                                            )
                                          : displayEdit == false
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      child: Text('Edit Item',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          )),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              elevation: 10,
                                                              primary:
                                                                  Colors.blue),
                                                      onPressed: () =>
                                                          setState(() {
                                                        displayEdit = true;
                                                      }),
                                                    ),
                                                    SizedBox(height: 10),
                                                    ElevatedButton(
                                                        child: Text(
                                                            'Remove Item',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            )),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                elevation: 10,
                                                                primary:
                                                                    Colors.red),
                                                        onPressed: () {
                                                          removeItem(doc.id);
                                                          displaySettings
                                                              .removeAt(index);
                                                          setState(() {});
                                                        }),
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        onTap: () => setState(
                                                              () {
                                                                displaySettings[
                                                                        index] =
                                                                    false;
                                                              },
                                                            ),
                                                        child: Text("Cancel")),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextField(
                                                        controller:
                                                            _textController),
                                                    SizedBox(height: 10),
                                                    ElevatedButton(
                                                        child: Text('Submit',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            )),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                elevation: 10,
                                                                primary: Colors
                                                                    .blue),
                                                        onPressed: () {
                                                          if (_textController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              double.tryParse(
                                                                      _textController
                                                                          .text
                                                                          .toString()) !=
                                                                  null) {
                                                            editItem(
                                                                doc.id,
                                                                _textController
                                                                    .text,
                                                                index);
                                                          }
                                                        }),
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        onTap: () => setState(
                                                              () {
                                                                displaySettings[
                                                                        index] =
                                                                    false;
                                                              },
                                                            ),
                                                        child: Text("Cancel")),
                                                  ],
                                                ),
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
