// ignore_for_file: prefer_const_constructors

import 'package:columbuslist/pages/contact_page.dart';
import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/pages/profile_page.dart';
import 'package:columbuslist/pages/signup_page.dart';
import 'package:columbuslist/pages/wishlist_page.dart';
import 'package:columbuslist/services/locator.dart';
import 'package:columbuslist/services/navigation_service.dart';
import 'package:columbuslist/variables.dart';
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

  void sell() {}

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Align(
                    child: Text("Find and sell books",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  isLoggedIn == true
                      ? Positioned(
                          top: -5,
                          right: 5,
                          child: ElevatedButton(
                            child: Icon(Icons.bookmark),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                elevation: 10),
                            onPressed: () {
                              locator<NavigationService>()
                                  .navigateTo(WishlistPage.route);
                            },
                          ),
                        )
                      : Text(""),
                ]),
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                isLoggedIn == true
                    ? Text(
                        auth.currentUser!.email!,
                      )
                    : Text(""),
                isLoggedIn == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            child: Center(
                                child: Text(
                              "Login",
                            )),
                            onTap: () {
                              locator<NavigationService>()
                                  .navigateTo(LoginPage.route);
                              refreshState();
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            child: Center(
                                child: Text(
                              "Logout",
                            )),
                            onTap: () {
                              auth.signOut();
                              locator<NavigationService>()
                                  .navigateTo(LoginPage.route);
                            }),
                      ),
                isLoggedIn == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            child: Center(
                                child: Text(
                              "Sign Up",
                            )),
                            onTap: () {
                              locator<NavigationService>()
                                  .navigateTo(SignupPage.route);
                            }),
                      )
                    : Text(""),
              ],
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
              isLoggedIn == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          child: Center(
                              child: Text(
                            "Profile",
                            style: TextStyle(fontSize: 15),
                          )),
                          onTap: () {
                            locator<NavigationService>()
                                .navigateTo(ProfilePage.route);
                            refreshState();
                          }),
                    )
                  : Text(""),
            ],
          ),
        ),
        body: widget.child);
  }
}
