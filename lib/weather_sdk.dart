library weather_sdk;

import 'package:weather_sdk/model/location_data.dart';
import 'package:weather_sdk/weather_api.dart';
import 'package:weather_sdk/model/weather_data.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

class WeatherSDK {
  final WeatherApi _api;

  WeatherSDK()
      : _api = OpenWeatherMapApi(
    WeatherSDKInitializer().apiKey,
    temperatureUnit: WeatherSDKInitializer().units,
  );

  Future<WeatherData> fetchWeather(double latitude, double longitude) async {
    return _api.fetchWeather(latitude, longitude);
  }

  Future<List<LocationData>> searchLocation(String city, {int limit = 10}) async {
    return _api.searchLocation(city, limit: limit);
  }

  void updateUnits(TemperatureUnit units) {
    WeatherSDKInitializer().updateUnits(units);
  }
}