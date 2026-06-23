import 'weather_model.dart';
import 'db_helper.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository({required this.weatherService});

  Future<WeatherModel> getWeather(String city) async {
    return await weatherService.fetchWeather(city);
  }
}