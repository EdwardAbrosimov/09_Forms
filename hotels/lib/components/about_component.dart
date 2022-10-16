import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:http/http.dart' as http;

Future<HotelInfo> fetchHotelInfo(http.Client client, String uuid) async {
  final response =
      await client.get(Uri.parse('https://run.mocky.io/v3/' + uuid));
  return compute(parseHotelInfo, response.body);
}

HotelInfo parseHotelInfo(String responseBody) {
  debugPrint("in compute:\n" + responseBody);
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  HotelInfo info = parsed.map<HotelInfo>((json) => HotelInfo.fromJson(json));
  // debugPrint(info.preview.name);
  return parsed.map<HotelInfo>((json) => HotelInfo.fromJson(json));
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, this.uuid = "Unknown"});
  final String uuid;
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // late Future<HotelInfo> _hotel;
  late HotelInfo _hotel;
  bool isLoading = false;
  @override
  void initState() {
    // debugPrint('on init' + widget.uuid);
    debugPrint(widget.uuid);
    gethotelInfo(widget.uuid);
    super.initState();
    // _hotel = fetchHotelInfo(http.Client(), widget.uuid);
  }

  gethotelInfo(String uuid) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse('https://run.mocky.io/v3/' + uuid));
      Map<String, dynamic> parsed = jsonDecode(response.body);
      debugPrint(parsed.toString());
      _hotel = HotelInfo.fromJson(parsed);

      debugPrint(_hotel.price.toString());
      for (var element in _hotel.photos) {
        debugPrint(element);
      }
      // _hotel = parsed.map<HotelInfo>((info) => HotelInfo.fromJson(info));
      // _hotel = parsed.map<HotelInfo>((info) => HotelInfo.fromJson(info));
      // debugPrint(_hotel.preview.name);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            isLoading ? const CircularProgressIndicator() : Text(_hotel.name),
        centerTitle: true,
      ),
    );
  }
}
