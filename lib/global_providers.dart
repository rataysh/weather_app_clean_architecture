import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/datasources/local/shared_preferences_storage.dart';
import 'package:weather_app/data/datasources/remote/weather_api_service.dart';
import 'package:weather_app/data/repositories/search_history_repository_impl.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/search_history_interface.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';
import 'package:weather_app/domain/usecases/clear_search_history_usecase.dart';
import 'package:weather_app/domain/usecases/get_city_coordinates_usecase.dart';
import 'package:weather_app/domain/usecases/get_forecast_usecase.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/domain/usecases/save_search_history_usecase.dart';
import 'package:weather_app/domain/usecases/get_search_history_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// Provider for WeatherApiService
final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiService(dio: ref.watch(dioProvider));
});

// Provider for SharedPreferencesStorage
final sharedPreferencesStorageProvider =
    Provider<SharedPreferencesStorage>((ref) {
  return SharedPreferencesStorage();
});

// Provider for WeatherRepositoryInterface
final weatherRepositoryProvider = Provider<WeatherRepositoryInterface>((ref) {
  return WeatherRepositoryImpl(
    apiService: ref.watch(weatherApiServiceProvider),
  );
});

// Provider for SearchHistoryRepositoryInterface
final searchHistoryRepositoryProvider =
    Provider<SearchHistoryRepositoryInterface>((ref) {
  return SearchHistoryRepositoryImpl(
    storage: ref.watch(sharedPreferencesStorageProvider),
  );
});

// UseCase providers
final getCityCoordinatesUseCaseProvider =
    Provider<GetCityCoordinatesUseCase>((ref) {
  return GetCityCoordinatesUseCase(ref.watch(weatherRepositoryProvider));
});

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  return GetWeatherUseCase(ref.watch(weatherRepositoryProvider));
});

final saveSearchHistoryUseCaseProvider =
    Provider<SaveSearchHistoryUseCase>((ref) {
  return SaveSearchHistoryUseCase(
    ref.watch(searchHistoryRepositoryProvider),
  );
});

final getSearchHistoryUseCaseProvider =
    Provider<GetSearchHistoryUseCase>((ref) {
  return GetSearchHistoryUseCase(
    ref.watch(searchHistoryRepositoryProvider),
  );
});

final clearSearchHistoryUseCaseProvider =
    Provider<ClearSearchHistoryUseCase>((ref) {
  final searchHistoryRepo = ref.watch(searchHistoryRepositoryProvider);
  return ClearSearchHistoryUseCase(searchHistoryRepo);
});

final getForecastUseCaseProvider = Provider<GetForecastUseCase>((ref) {
  return GetForecastUseCase(ref.watch(weatherRepositoryProvider));
});
