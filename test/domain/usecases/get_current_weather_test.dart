import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
      cityName: 'Surat',
      description: 'Few Clouds',
      main: 'Clouds',
      iconCode: '02d',
      temperature: 302.288,
      humidity: 70,
      pressure: 1009);

  const testCityName = 'Surat';

  test(
    'should get current weather details from the repository',
    () async {
      when(mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((realInvocation) async => const Right(testWeatherDetail));

      final result = await getCurrentWeatherUseCase.execute(testCityName);

      expect(result, const Right(testWeatherDetail));
    },
  );
}
