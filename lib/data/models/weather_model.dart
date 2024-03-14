import 'package:equatable/equatable.dart';
import 'package:weather_tdd/domain/entities/weather.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final String description;
  final String main;
  final String iconCode;
  final double temperature;
  final int humidity;
  final int pressure;

  const WeatherModel(
      {required this.cityName,
      required this.description,
      required this.main,
      required this.iconCode,
      required this.temperature,
      required this.humidity,
      required this.pressure});

  @override
  List<Object?> get props => [
        cityName,
        description,
        main,
        iconCode,
        temperature,
        humidity,
        pressure,
      ];

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        description: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        iconCode: json['weather'][0]['icon'],
        main: json['weather'][0]['main'],
        pressure: json['main']['pressure'],
        temperature: json['main']['temp'],
      );

  Map<String, dynamic> toJson() => {
        'weather': [
          {
            'main': main,
            'description': description,
            'icon': iconCode,
          },
        ],
        'main': [
          {
            'temp': temperature,
            "pressure": pressure,
            "humidity": humidity,
          },
        ],
        'name': cityName,
      };

  WeatherEntity toEntity() => WeatherEntity(
        cityName: cityName,
        description: description,
        main: main,
        iconCode: iconCode,
        temperature: temperature,
        humidity: humidity,
        pressure: pressure,
      );
}
