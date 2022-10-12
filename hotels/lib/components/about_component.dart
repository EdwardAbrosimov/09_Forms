import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, this.uuid = "Unknown"});
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uuid),
        centerTitle: true,
      ),
    );
  }
}
