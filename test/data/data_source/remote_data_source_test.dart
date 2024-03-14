import 'package:mockito/mockito.dart';
import 'package:weather_tdd/core/constants/constants.dart';
import 'package:weather_tdd/core/error/exception.dart';
import 'package:weather_tdd/data/data_source/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:weather_tdd/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'Surat';

  group(
    'get current weather',
    () {
      test(
        'should return weather model when the response code is 200',
        () async {
          when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
              .thenAnswer(
            (realInvocation) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_data.json'),
              200,
            ),
          );

          final result =
              await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

          expect(result, isA<WeatherModel>());
        },
      );

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
              .thenAnswer(
            (realInvocation) async => http.Response(
              'Not Found',
              404,
            ),
          );

          expectAsync0(() async {
            try {
              await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
              fail('Expected ServerException was not thrown');
            } catch (e) {
              expect(e, isA<ServerException>());
            }
          });

          // final result =
          //     await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
          //
          // expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}