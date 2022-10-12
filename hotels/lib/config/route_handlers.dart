import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../components/about_component.dart';
import '../components/home_component.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const MyHomePage();
  },
);

class AboutArguments {
  final String uuid;
  AboutArguments(this.uuid);
}

var aboutHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  final args = ModalRoute.of(context!)?.settings.arguments as AboutArguments;
  return AboutPage(uuid: args.uuid);
});
