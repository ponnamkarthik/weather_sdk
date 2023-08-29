import 'dart:async';

import 'package:weather_sdk/model/location_data.dart';
import 'package:weather_sdk/weather_api.dart';
import 'package:weather_sdk/model/weather_data.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

class WeatherSDK {
  final WeatherApi _api;

  final _weatherDataController = StreamController<WeatherData>.broadcast();

  static final WeatherSDK _instance = WeatherSDK._internal();

  factory WeatherSDK() => _instance;

  WeatherSDK._internal()
      : _api = OpenWeatherMapApi(
    WeatherSDKInitializer().apiKey,
    temperatureUnit: WeatherSDKInitializer().units,
  ) {
    WeatherSDKInitializer().unitsStream.listen((units) {
      // Units have changed, refresh weather data
      fetchWeatherData();
    });
  }

  Stream<WeatherData> get weatherDataStream => _weatherDataController.stream;

  double? lat;
  double? lon;
  DateTime? date;

  Future<void> fetchWeatherData() async {
    final weatherData = await fetchWeather(lat!, lon!, date!);
    _weatherDataController.add(weatherData);
  }

  Future<WeatherData> fetchWeather(double latitude, double longitude, DateTime dateTime) async {
    lat = latitude;
    lon = longitude;
    date = dateTime;
    final weatherData = await _api.fetchWeather(latitude, longitude, dateTime);
    _weatherDataController.add(weatherData);
    return weatherData;
  }

  Future<List<LocationData>> searchLocation(String city, {int limit = 10}) async {
    return _api.searchLocation(city, limit: limit);
  }

  void updateUnits(TemperatureUnit units) {
    WeatherSDKInitializer().updateUnits(units);
  }

  void dispose() {
    _weatherDataController.close();
  }
}
