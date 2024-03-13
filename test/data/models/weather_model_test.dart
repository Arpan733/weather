import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_tdd/data/models/weather_model.dart';
import 'package:weather_tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Surat',
    description: 'Few Clouds',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302.288,
    humidity: 70,
    pressure: 1009,
  );

  test(
    'should be subclass of weather entity',
    () {
      expect(testWeatherModel, isA<WeatherModel>());
    },
  );

  test(
    'should return a valid model from json',
    () {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('helpers/dummy_data/dummy_weather_data.json'));

      final result = WeatherModel.fromJson(jsonMap);

      expect(result, isA<WeatherModel>());
    },
  );

  test(
    'should return a json map containing proper data',
    () {
      final result = testWeatherModel.toJson();

      final expectedJsonMap = {
        'name': 'Surat',
        "weather": [
          {
            "description": 'Few Clouds',
            "main": 'Clouds',
            "icon": '02d',
          },
        ],
        "main": [
          {
            "temp": 302.288,
            "humidity": 70,
            "pressure": 1009,
          },
        ],
      };

      expect(result, expectedJsonMap);
    },
  );
}
