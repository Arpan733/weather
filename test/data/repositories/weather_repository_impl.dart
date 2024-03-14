import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/core/error/exception.dart';
import 'package:weather_tdd/core/error/failure.dart';
import 'package:weather_tdd/data/models/weather_model.dart';
import 'package:weather_tdd/data/repositories/weather_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_tdd/domain/entities/weather.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Surat',
    description: 'Few Clouds',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302.288,
    humidity: 70,
    pressure: 1009,
  );

  const testWeatherDetail = WeatherEntity(
    cityName: 'Surat',
    description: 'Few Clouds',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302.288,
    humidity: 70,
    pressure: 1009,
  );

  const testCityName = 'Surat';

  group(
    'get current weather',
    () {
      test(
        'should return current weather when a call to data source is successful',
        () async {
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenAnswer((realInvocation) async => testWeatherModel);

          final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

          expect(result, equals(const Right(testWeatherDetail)));
        },
      );

      test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(ServerException());

          final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

          expect(result, equals(const Left(ServerFailure('An error has occurred'))));
        },
      );

      test(
        'should return connection failure when device has no internet',
        () async {
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(const SocketException('Failed to connect to the network'));

          final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

          expect(result,
              equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );
}
