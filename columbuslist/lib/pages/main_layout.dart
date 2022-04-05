// ignore_for_file: prefer_const_constructors

import 'package:columbuslist/pages/contact_page.dart';
import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final Widget? child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Columbus List",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 51, 91, 100),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Find and sell books",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  locator<NavigationService>().currentRoute == "/home"
                      ? Container(
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
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Center(
                      child: Text(
                    "Login",
                  )),
                  onTap: () {
                    locator<NavigationService>().navigateTo(LoginPage.route);
                    refreshState();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Center(
                      child: Text(
                    "Sign Up",
                  )),
                  onTap: () {
                    print("GO TO SIGN UP PAGE");
                  }),
            ),
          ],
          actionsIconTheme: IconThemeData(
            size: 32,
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Center(
                        child: Text(
                      "Home Page",
                      style: TextStyle(fontSize: 15),
                    )),
                    onTap: () {
                      locator<NavigationService>().navigateTo(HomePage.route);
                      refreshState();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Center(
                        child: Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 15),
                    )),
                    onTap: () {
                      locator<NavigationService>()
                          .navigateTo(ContactPage.route);
                      refreshState();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Center(
                        child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 15),
                    )),
                    onTap: () {
                      locator<NavigationService>().navigateTo(HomePage.route);
                      refreshState();
                    }),
              ),
            ],
          ),
        ),
        body: widget.child);
  }
}
