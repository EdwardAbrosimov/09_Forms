import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:http/http.dart' as http;

Future<HotelInfo> fetchHotelInfo(http.Client client, String uuid) async {
  final response =
      await client.get(Uri.parse('https://run.mocky.io/v3/' + uuid));
  // var data = response.body;
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<HotelInfo>((json) => HotelInfo.fromJson(json));
}

HotelInfo parseHotelInfo(String responseBody) {
  debugPrint("in compute:\n" + responseBody);
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  HotelInfo info = parsed.map<HotelInfo>((json) => HotelInfo.fromJson(json));
  debugPrint(info.preview.name);
  return info;
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, this.uuid = "Unknown"});
  final String uuid;
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late Future<HotelInfo> _hotel;

  @override
  void initState() {
    // debugPrint('on init' + widget.uuid);
    debugPrint(widget.uuid);
    _hotel = fetchHotelInfo(http.Client(), widget.uuid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<HotelInfo>(
          future: _hotel,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data?.preview == null
                    ? const Text('null')
                    : Text(snapshot.data!.preview.name);
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
        centerTitle: true,
      ),
    );
  }
}
