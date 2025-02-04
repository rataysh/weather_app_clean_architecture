import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/home/home_page_viewmodel.dart';
import 'package:weather_app/global_providers.dart';

final homePageProvider =
    StateNotifierProvider<HomePageViewModel, HomePageState>((ref) {
  return HomePageViewModel(
    getCityCoordinatesUseCase: ref.watch(getCityCoordinatesUseCaseProvider),
    getWeatherUseCase: ref.watch(getWeatherUseCaseProvider),
    saveSearchHistoryUseCase: ref.watch(saveSearchHistoryUseCaseProvider),
  );
});

