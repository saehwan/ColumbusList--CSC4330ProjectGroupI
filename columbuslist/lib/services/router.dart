// ignore_for_file: prefer_const_constructors

import 'package:columbuslist/pages/contact_page.dart';
import 'package:columbuslist/pages/home_page.dart';
import 'package:columbuslist/pages/login_page.dart';
import 'package:columbuslist/pages/profile_page.dart';
import 'package:columbuslist/pages/sell_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return _getPageRoute(HomePage(), settings);
    case LoginPage.route:
      return _getPageRoute(LoginPage(), settings);
    case ContactPage.route:
      return _getPageRoute(ContactPage(), settings);
    case ProfilePage.route:
      return _getPageRoute(ProfilePage(), settings);
    case SellPage.route:
      return _getPageRoute(SellPage(), settings);
    default:
      return _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String? routeName;
  _FadeRoute({required this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
