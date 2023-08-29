import 'dart:async';

enum TemperatureUnit {
  metric,
  imperial
}

class WeatherSDKInitializer {
  static final WeatherSDKInitializer _instance = WeatherSDKInitializer._internal();
  factory WeatherSDKInitializer() => _instance;

  late String _apiKey;
  late TemperatureUnit _units;

  final _unitsController = StreamController<TemperatureUnit>.broadcast();

  WeatherSDKInitializer._internal();

  void initialize({required String apiKey, TemperatureUnit temperatureUnit = TemperatureUnit.metric}) {
    _apiKey = apiKey;
    _units = temperatureUnit;
  }

  void updateUnits(TemperatureUnit units) {
    _units = units;
    _unitsController.add(_units); // Notify listeners about the unit change
  }

  Stream<TemperatureUnit> get unitsStream => _unitsController.stream;

  String get apiKey => _apiKey;
  TemperatureUnit get units => _units;
}