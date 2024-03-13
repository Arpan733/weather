import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String description;
  final String main;
  final String iconCode;
  final double temperature;
  final int humidity;
  final int pressure;

  const WeatherEntity(
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
}
