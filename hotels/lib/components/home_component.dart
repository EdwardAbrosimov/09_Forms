import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:http/http.dart' as http;

Future<List<HotelPreview>> fetchHotels(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301'));
  return compute(parseHotels, response.body);
}

List<HotelPreview> parseHotels(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<HotelPreview>((json) => HotelPreview.fromJson(json))
      .toList();
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.list),
              tooltip: 'Display hotels in list',
              onPressed: (() {})),
          IconButton(
            icon: const Icon(Icons.grid_view),
            tooltip: 'Display hotels in grid',
            onPressed: (() {}),
          )
        ],
      ),
      body: FutureBuilder<List<HotelPreview>>(
        future: fetchHotels(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return HotelsList(hotels: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class HotelsList extends StatelessWidget {
  const HotelsList({super.key, required this.hotels});

  final List<HotelPreview> hotels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            'assets/images/${hotels[index].poster}',
            fit: BoxFit.cover,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        );
      },
    );
  }
}
