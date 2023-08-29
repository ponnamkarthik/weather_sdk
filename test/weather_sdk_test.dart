import 'package:flutter_test/flutter_test.dart';

import 'package:weather_sdk/weather_sdk.dart';
import 'package:weather_sdk/weather_sdk_initializer.dart';

void main() {
  test('fetch weather', () async {
    final sdkInitializer = WeatherSDKInitializer();
    // sdkInitializer.initialize(apiKey: "8c5d14aecf406287e03ef8cab87360f9");
    sdkInitializer.initialize(apiKey: "bd5e378503939ddaee76f12ad7a97608");
    // sdkInitializer.initialize(apiKey: "53f85eb4f658c8ed7d55cfd641bf70fc");

    final sdk = WeatherSDK();
    await sdk.fetchWeather(17.360589, 78.4740613, DateTime.now());
  });
  // test('search weather location', () async {
  //   final sdkInitializer = WeatherSDKInitializer();
  //   // sdkInitializer.initialize(apiKey: "8c5d14aecf406287e03ef8cab87360f9");
  //   sdkInitializer.initialize(apiKey: "bd5e378503939ddaee76f12ad7a97608");
  //   // sdkInitializer.initialize(apiKey: "53f85eb4f658c8ed7d55cfd641bf70fc");
  //
  //   final sdk = WeatherSDK();
  //   await sdk.searchLocation("Hyderabad");
  // });
}
