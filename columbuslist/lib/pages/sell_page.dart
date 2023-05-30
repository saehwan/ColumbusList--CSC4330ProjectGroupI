// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/variables.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
  String? name, description, image;
  double? price;
  Uint8List? imageFile;

  Image _imageWidget = Image.asset("");

  UploadTask? uploadTask;
  bool uploading = false;

  List selectedTags = [];

  listItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var itemKey = itemcollection.doc().id;
      itemcollection.doc(itemKey).set({
        'name': name,
        'description': description,
        'price': price,
        'tags': tags,
        'image': name,
      });
    }
  }

  void createItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var itemKey = itemcollection.doc().id;
      uploadTask =
          storage.child('itemPics/' + itemKey + "/$name").putData(imageFile!);
      uploadTask!.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
          });
        } else {
          uploading = false;
        }
      }, onError: (Object e) {
        print(e); // FirebaseException
      });
      var dowurl = await (await uploadTask)!.ref.getDownloadURL();
      image = dowurl.toString();
      itemcollection.doc(itemKey).set({
        'name': name,
        'description': description,
        'price': price,
        'tags': selectedTags,
        'image': image,
        'contact': auth.currentUser!.email,
      });
      locator<NavigationService>().navigateTo(HomePage.route);
    }
  }

  Future<void> getImageInfo() async {
    var mediaData = await ImagePickerWeb.getImageAsBytes();

    if (mediaData != null) {
      setState(() {
        _imageWidget = Image.memory(mediaData, scale: 10);
        image = "test";
        imageFile = mediaData;
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
                    width: 500,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          image == null
                              ? InkWell(
                                  onTap: () => getImageInfo(),
                                  child: Icon(Icons.person, size: 250))
                              : InkWell(
                                  onTap: () => getImageInfo(),
                                  child: _imageWidget),
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
                                onSaved: (input) =>
                                    price = double.parse(input!),
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
                              onSaved: (input) => description = input!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.4),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  MultiSelectDialogField(
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText: Text("Tags"),
                                    title: Text("Tags"),
                                    items: tags
                                        .map((e) =>
                                            MultiSelectItem<String>(e, e))
                                        .toList(),
                                    onConfirm: (values) {
                                      setState(() {
                                        selectedTags = values;
                                      });
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          selectedTags.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  selectedTags == null || selectedTags.isEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "None selected",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ))
                                      : Container(),
                                ],
                              ),
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
                    onPressed: () => createItem(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
