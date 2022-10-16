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
    );
  }
}
