import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:weather_app/domain/repositories/search_history_interface.dart';

class GetSearchHistoryUseCase {
  final SearchHistoryRepositoryInterface repository;

  GetSearchHistoryUseCase(this.repository);

  Future<List<SearchHistoryEntity>> call() async {
    return await repository.getSearchHistory();
  }
}
