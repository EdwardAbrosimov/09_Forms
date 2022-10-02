import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../components/about_component.dart';
import '../components/home_component.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return HomeView();
  },
);

var aboutHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return AboutView(params["uuid"][0]);
});
