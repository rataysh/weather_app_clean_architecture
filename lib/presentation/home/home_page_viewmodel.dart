import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/usecases/get_city_coordinates_usecase.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/domain/usecases/save_search_history_usecase.dart';

class HomePageState {
  final bool isLoading;
  final WeatherEntity? weather;
  final String? errorMessage;

  HomePageState({
    this.isLoading = false,
    this.weather,
    this.errorMessage,
  });

  HomePageState copyWith({
    bool? isLoading,
    WeatherEntity? weather,
    String? errorMessage,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      weather: weather ?? this.weather,
      errorMessage: errorMessage,
    );
  }
}

class HomePageViewModel extends StateNotifier<HomePageState> {
  final GetCityCoordinatesUseCase getCityCoordinatesUseCase;
  final GetWeatherUseCase getWeatherUseCase;
  final SaveSearchHistoryUseCase saveSearchHistoryUseCase;

  HomePageViewModel({
    required this.getCityCoordinatesUseCase,
    required this.getWeatherUseCase,
    required this.saveSearchHistoryUseCase,
  }) : super(HomePageState());

  // Method to fetch weather data for a given city name
  Future<void> fetchWeather(String cityName) async {
    try {
      // Set loading state
      state =
          state.copyWith(isLoading: true, weather: null, errorMessage: null);

      final city = await getCityCoordinatesUseCase(cityName);
      final weather = await getWeatherUseCase(city.lat, city.lon);

      // Test delay to shimmer effect showing
      await Future.delayed(Duration(seconds: 3));

      state = state.copyWith(
          isLoading: false, weather: weather, errorMessage: null);

      try {
        await saveSearchHistoryUseCase(
          SearchHistoryEntity(
            cityName: cityName,
            searchTime: DateTime.now(),
            temperature: weather.temperature,
          ),
        );
      } catch (e) {
        throw Exception('Failed to save search history');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        weather: null,
        errorMessage: e.toString(),
      );
    }
  }
}
