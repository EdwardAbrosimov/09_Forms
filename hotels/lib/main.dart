import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hotels/components/home_component.dart';
import '../../config/routes.dart';

void main() {
  runApp(const MyApp());
}

class Application {
  static late final FluroRouter router;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Hotels',
      initialRoute: Routes.home,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}
