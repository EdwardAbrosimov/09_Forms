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
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _hotel.photos.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 16.0,
                            height: 16.0,
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
                  ],
                ),
    );
  }
}
