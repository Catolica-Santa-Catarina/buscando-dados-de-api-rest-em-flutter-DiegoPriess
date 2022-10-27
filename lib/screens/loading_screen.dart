import 'package:flutter/material.dart';
import 'package:tempo_template/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '916b38251154b435e6fb87bd3cdadad0';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final Location _location = Location();

  double _latitude = 0;
  double _longitude = 0;

  void getData() async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonData = jsonDecode(data);

      var cityName = jsonData['name'];
      var temperature = jsonData['main']['temp'];
      var weatherCondition = jsonData['weather'][0]['id'];
      print('cidade: $cityName, temperatura: $temperature, condição: $weatherCondition');
    } else {
      print(response.statusCode);
    }
  }

  Future<void> getLocation() async {
    await _location.getCurrentPosition();

    _latitude = _location.getLatitude();
    _longitude = _location.getLongitude();

    getData();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
