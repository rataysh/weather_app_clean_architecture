import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:weather_app/domain/usecases/get_search_history_usecase.dart';
import 'package:weather_app/domain/usecases/clear_search_history_usecase.dart';

class HistoryPageState {
  final bool isLoading;
  final List<SearchHistoryEntity> historyList;
  final String? errorMessage;

  HistoryPageState({
    this.isLoading = false,
    this.historyList = const [],
    this.errorMessage,
  });

  HistoryPageState copyWith({
    bool? isLoading,
    List<SearchHistoryEntity>? historyList,
    String? errorMessage,
  }) {
    return HistoryPageState(
      isLoading: isLoading ?? this.isLoading,
      historyList: historyList ?? this.historyList,
      errorMessage: errorMessage,
    );
  }
}

class HistoryPageViewModel extends StateNotifier<HistoryPageState> {
  final GetSearchHistoryUseCase getSearchHistoryUseCase;
  final ClearSearchHistoryUseCase clearSearchHistoryUseCase;

  HistoryPageViewModel({
    required this.getSearchHistoryUseCase,
    required this.clearSearchHistoryUseCase,
  }) : super(HistoryPageState());

  Future<void> fetchHistory() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final history = await getSearchHistoryUseCase();
      state = state.copyWith(isLoading: false, historyList: history);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> clearHistory() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      await clearSearchHistoryUseCase();
      state = state.copyWith(isLoading: false, historyList: []);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
