import 'package:flutter/material.dart';
import 'package:weather_sdk/model/weather_data.dart';
import 'package:weather_sdk/weather_sdk.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

class WeatherWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final bool showWeatherIcon;
  final bool showTemperature;
  final DateTime? dateTime;

  const WeatherWidget({
    Key? key,
    this.dateTime,
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
    _updateWeatherData();

    WeatherSDKInitializer().unitsStream.listen((units) {
      _updateWeatherData();
    });
  }

  void _updateWeatherData() {
    setState(() {
      _weatherDataFuture =
          _weatherSDK.fetchWeather(widget.latitude, widget.longitude, widget.dateTime ?? DateTime.now());
    });
  }


  @override
  void didUpdateWidget(covariant WeatherWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dateTime != oldWidget.dateTime) {
      _updateWeatherData();
    }
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
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Weather in ${weatherData.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (widget.showWeatherIcon)
                    Image.network(
                      'http://openweathermap.org/img/w/${weatherData.weather[0].icon}.png',
                      height: 80,
                      width: 80,
                    ),
                  SizedBox(height: 16),
                  if (widget.showTemperature)
                    Text(
                      '${formatTemperature(weatherData.main.temp)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          );
        } else {
          return Text('No weather data available');
        }
      },
    );
  }
}
