import 'package:dartz/dartz.dart';
import 'package:weather_tdd/core/error/failure.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  late final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
