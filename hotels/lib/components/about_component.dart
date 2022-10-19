import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:dio/dio.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, this.uuid = "Unknown"});
  final String uuid;
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late HotelInfo _hotel;
  bool isLoading = false;
  bool hasError = false;
  String errorString = '';
  int errorCode = 404;
  final Dio _dio = Dio();
  int _currentImage = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    gethotelInfo(widget.uuid);
    super.initState();
  }

  gethotelInfo(String uuid) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _dio.get('https://run.mocky.io/v3/' + uuid);
      var data = response.data;
      _hotel = HotelInfo.fromJson(data);
    } on DioError catch (e) {
      setState(() {
        hasError = true;
        errorCode = e.response?.statusCode ?? 404;
        errorString = e.response?.data["message"] ?? 'Empty error';
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? Text(errorCode.toString())
                : Text(_hotel.name),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(errorString),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CarouselSlider(
                          items: _hotel.photos
                              .map((item) => Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      child: Image.asset(
                                        'assets/images/$item',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImage = index;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _hotel.photos.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: MediaQuery.of(context).size.width <= 300
                                    ? 8
                                    : 16.0,
                                height: MediaQuery.of(context).size.width <= 300
                                    ? 8
                                    : 16.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.purple
                                            : Colors.deepPurple)
                                        .withOpacity(_currentImage == entry.key
                                            ? 0.9
                                            : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 4,
                                shadowColor: Colors.deepPurpleAccent,
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Основная информация',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text('Страна:'),
                                                const SizedBox(width: 20),
                                                Text(_hotel.address.country,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text('Город:'),
                                                const SizedBox(width: 20),
                                                Text(_hotel.address.city,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text('Улица:'),
                                                const SizedBox(width: 20),
                                                Text(_hotel.address.street,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text('Рейтинг:'),
                                                const SizedBox(width: 20),
                                                Text(_hotel.rating.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.deepPurpleAccent,
                                  margin: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text('Бесплатные',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: _hotel.services.free
                                                .map((service) {
                                              return Row(children: [
                                                const Text("\u2022"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    service,
                                                  ),
                                                )
                                              ]);
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.deepPurpleAccent,
                                  margin: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text('Платные',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: _hotel.services.paid
                                                .map((service) {
                                              return Row(children: [
                                                const Text("\u2022"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    service,
                                                  ),
                                                )
                                              ]);
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
