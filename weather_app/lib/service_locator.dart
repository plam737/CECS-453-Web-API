import 'db_helper.dart';
import 'note_repository.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final WeatherService weatherService;
  late final WeatherRepository weatherRepository;

  void setup() {
    weatherService = WeatherService();
    weatherRepository = WeatherRepository(weatherService: weatherService);
  }
}

final serviceLocator = ServiceLocator();