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
    const appTitle = 'Hotels';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<List<HotelPreview>>? _hotels = fetchHotels(http.Client());
  bool showGrid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.list),
              tooltip: 'Display hotels in list',
              onPressed: (() {
                setState(() {
                  showGrid = false;
                });
              })),
          IconButton(
            icon: const Icon(Icons.grid_view),
            tooltip: 'Display hotels in grid',
            onPressed: (() {
              setState(() {
                showGrid = true;
              });
            }),
          )
        ],
      ),
      body: FutureBuilder<List<HotelPreview>>(
        future: _hotels,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text('NONE'));
            case ConnectionState.active:
              return const Center(child: Text('ACTIVE'));
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return HotelsList(
                hotels: snapshot.data!,
                gridView: showGrid,
              );
          }
        },
      ),
    );
  }
}

class HotelsList extends StatelessWidget {
  const HotelsList({super.key, required this.hotels, required this.gridView});

  final bool gridView;
  final List<HotelPreview> hotels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridView ? 2 : 1,
      ),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          shadowColor: Colors.deepPurpleAccent,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: Image.asset(
                  'assets/images/${hotels[index].poster}',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: gridView
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  hotels[index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepPurple),
                                ),
                                onPressed: () {},
                                child: const Text('Подробнее'),
                              ),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  hotels[index].name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.deepPurple),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Подробнее'),
                                ),
                              )
                            ],
                          ),
                        ))
            ],
          ),
        );
      },
    );
  }
}
