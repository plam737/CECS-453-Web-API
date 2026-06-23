import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'note_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository weatherRepository;

  WeatherProvider({required this.weatherRepository});

  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadWeather(String city) async {
    isLoading = true;
    errorMessage = null;
    weather = null;
    notifyListeners();

    try {
      weather = await weatherRepository.getWeather(city);
    } catch (e) {
      errorMessage = 'City not found. Please check the name and try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}