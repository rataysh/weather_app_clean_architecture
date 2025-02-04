import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/history/history_page_viewmodel.dart';
import 'package:weather_app/global_providers.dart';

final historyPageProvider =
    StateNotifierProvider<HistoryPageViewModel, HistoryPageState>((ref) {
  return HistoryPageViewModel(
    getSearchHistoryUseCase: ref.watch(getSearchHistoryUseCaseProvider),
    clearSearchHistoryUseCase: ref.watch(clearSearchHistoryUseCaseProvider),
  );
});
