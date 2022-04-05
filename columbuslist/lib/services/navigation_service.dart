import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String currentRoute = "";

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String>? queryParams}) {
    currentRoute = routeName;
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState!.pushNamed(routeName);
  }
}
