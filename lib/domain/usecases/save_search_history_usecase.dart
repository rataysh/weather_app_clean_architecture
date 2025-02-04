import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:weather_app/domain/repositories/search_history_interface.dart';

class SaveSearchHistoryUseCase {
  final SearchHistoryRepositoryInterface repository;

  SaveSearchHistoryUseCase(this.repository);

  Future<void> call(SearchHistoryEntity history) async {
    await repository.saveSearchHistory(history);
  }
}
