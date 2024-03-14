import 'package:mockito/annotations.dart';
import 'package:weather_tdd/data/data_source/remote_data_source.dart';
import 'package:weather_tdd/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
