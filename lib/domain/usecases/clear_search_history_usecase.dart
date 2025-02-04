import 'package:weather_app/domain/repositories/search_history_interface.dart';

class ClearSearchHistoryUseCase {
  final SearchHistoryRepositoryInterface repository;

  ClearSearchHistoryUseCase(this.repository);

  Future<void> call() async {
    await repository.clearSearchHistory();
  }
}
