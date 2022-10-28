import 'package:flutter/material.dart';
import 'package:tempo_template/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/networking.dart';
import 'location_screen.dart';

const _apiKey = '916b38251154b435e6fb87bd3cdadad0';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Location location = Location();

  double latitude = 0;
  double longitude = 0;

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    pushToLocationScreen(weatherData);
  }

  Future<void> getLocation() async {
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
