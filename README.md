## Installation

```yaml
  weather_sdk:
    git:
      url: https://github.com/ponnamkarthik/weather_sdk
```

## Usage

```dart
final WeatherSDK _weatherSDK = WeatherSDK();

// Update Units
_weatherSDK.updateUnits(TemperatureUnit.metric);

// Search for location
_weatherSDK.searchLocation(query)

// Fetch Weather Data
_weatherSDK.fetchWeather(latitude, longitude, dateTime)

```
## Initializing Weather

```dart
final sdkInitializer = WeatherSDKInitializer();
sdkInitializer.initialize(apiKey: "bd5e378503939ddaee76f12ad7a97608");
```

## Listen for unit changes

```dart
WeatherSDKInitializer().unitsStream.listen((units) {
// Units have changed, refresh weather data
setState(() {});
});
```


## Weather Widget

```dart
WeatherWidget(
    dateTime: selectedWeatherDate,
    latitude: _locationData!.lat,
    longitude: _locationData!.lon,
)
```