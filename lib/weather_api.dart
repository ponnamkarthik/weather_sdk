import 'package:http/http.dart' as http;
import 'package:weather_sdk/model/location_data.dart';
import 'package:weather_sdk/model/weather_data.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

abstract class WeatherApi {
  Future<WeatherData> fetchWeather(double latitude, double longitude);

  Future<List<LocationData>> searchLocation(String query, {int limit = 10});
}

class OpenWeatherMapApi implements WeatherApi {
  final String apiKey;
  final TemperatureUnit temperatureUnit;

  OpenWeatherMapApi(this.apiKey,
      {this.temperatureUnit = TemperatureUnit.metric});

  @override
  Future<WeatherData> fetchWeather(double latitude, double longitude) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=${temperatureUnit ==
            TemperatureUnit.metric ? 'metric' : 'imperial'}");

        final response = await http. get (url);

    if (response.statusCode == 200) {
      final weatherData = weatherDataFromJson(response.body);
      return weatherData;
    } else if (response.statusCode == 401) {
      throw Exception('API Key is invalid or missing');
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Future<List<LocationData>> searchLocation(String query,
      {int limit = 10}) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final locationData = locationDataFromJson(response.body);
      return locationData;
    } else if (response.statusCode == 401) {
      throw Exception('API Key is invalid or missing');
    } else {
      throw Exception('Failed to fetch location data');
    }
  }
}
