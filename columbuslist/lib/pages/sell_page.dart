// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:columbuslist/variables.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  static const String route = "/sell";

  @override
  State<SellPage> createState() => SellPageState();
}

class SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextfieldTagsController _controller = TextfieldTagsController();
  String? name, description, price, tags, images;

  listItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var itemKey = itemcollection.doc().id;
      itemcollection.doc(itemKey).set({
        'name': name,
        'description': description,
        'price': price,
        'tags': tags,
        'images': name,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 61, 107),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 700,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldTags(
                              textfieldTagsController: _controller,
                              initialTags: const [],
                              textSeparators: const [' ', ','],
                              letterCase: LetterCase.normal,
                              validator: (String tag) {
                                if (tag == 'php') {
                                  return 'No, please just no';
                                } else if (_controller.getTags!.contains(tag)) {
                                  return 'you already entered that';
                                }
                                return null;
                              },
                              inputfieldBuilder: (context, tec, fn, error,
                                  onChanged, onSubmitted) {
                                return ((context, sc, tags, onTagDelete) {
                                  return TextFormField(
                                    controller: _textController,
                                    onTap: () {
                                      //OpenDropdownMenu;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Tags",
                                      border: InputBorder.none,
                                      prefixIcon: tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: sc,
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  children:
                                                      tags.map((String tag) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    color: Color.fromARGB(
                                                        255, 74, 137, 92),
                                                  ),
                                                  margin: const EdgeInsets.only(
                                                      right: 10.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          '#$tag',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        onTap: () {
                                                          print(
                                                              "$tag selected");
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          size: 14.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233),
                                                        ),
                                                        onTap: () {
                                                          onTagDelete(tag);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList()),
                                            )
                                          : null,
                                    ),
                                    onFieldSubmitted: (text) => {
                                      onSubmitted!(text),
                                    },
                                    onChanged: (text) => {
                                      _textController.text = "",
                                    },
                                  );
                                });
                              },
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
            ),
          ),
        ));
  }
}
