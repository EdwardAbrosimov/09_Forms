import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import './route_handlers.dart';

class Routes {
  static String home = "/";
  static String about = "/about";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint("Route was not found!!!");
      return;
    });
    router.define(home,
        handler: homeHandler, transitionType: TransitionType.fadeIn);
    router.define(about,
        handler: aboutHandler, transitionType: TransitionType.inFromBottom);
  }
}
