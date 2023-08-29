import 'dart:convert';

List<LocationData> locationDataFromJson(String str) => List<LocationData>.from(json.decode(str).map((x) => LocationData.fromJson(x)));

String locationDataToJson(List<LocationData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationData {
  String name;
  double lat;
  double lon;
  String country;
  String state;

  LocationData({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    name: json["name"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    country: json["country"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lat": lat,
    "lon": lon,
    "country": country,
    "state": state,
  };
}
