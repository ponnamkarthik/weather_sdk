import 'package:flutter/material.dart';
import 'package:weather_sdk/model/weather_data.dart';
import 'package:weather_sdk/weather_sdk.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

class WeatherWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final bool showWeatherIcon;
  final bool showTemperature;

  const WeatherWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
    this.showWeatherIcon = true,
    this.showTemperature = true,
  }) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late WeatherSDK _weatherSDK;
  late Future<WeatherData> _weatherDataFuture;

  @override
  void initState() {
    super.initState();
    _weatherSDK = WeatherSDK();
    _weatherDataFuture =
        _weatherSDK.fetchWeather(widget.latitude, widget.longitude);

    WeatherSDKInitializer().unitsStream.listen((units) {
      print(units);
      // Units have changed, refresh weather data
      _weatherDataFuture =
          _weatherSDK.fetchWeather(widget.latitude, widget.longitude);
    });
  }

  String formatTemperature(double temperature) {
    final units = WeatherSDKInitializer().units;
    if (units == TemperatureUnit.metric) {
      return '$temperature°C';
    } else {
      return '$temperature°F';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData>(
      future: _weatherDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final weatherData = snapshot.data!;
          return Column(
            children: [
              // Location name
              Text(weatherData.name),
              if (widget.showWeatherIcon)
                Image.network(
                    'http://openweathermap.org/img/w/${weatherData.weather[0].icon}.png'),
              if (widget.showTemperature) Text('${formatTemperature(weatherData.main.temp)}'),
            ],
          );
        } else {
          return Text('No weather data available');
        }
      },
    );
  }
}
