import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/core/error/failure.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_tdd/presentation/bloc/weather_state.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

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

  test(
    'initial state should be empty',
    () {
      expect(weatherBloc.state, WeatherEmpty());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((realInvocation) async => const Right(testWeatherDetail));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(result: testWeatherDetail),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when get data is unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure('Server failure')));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure(message: 'Server failure'),
    ],
  );
}
