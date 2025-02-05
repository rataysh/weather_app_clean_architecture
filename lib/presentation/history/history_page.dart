import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/history/history_provider.dart';
import 'package:weather_app/presentation/widgets/history_card.dart';
import 'package:weather_app/core/theme/dimens.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyPageProvider.notifier).fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyPageProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text('Search History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(historyPageProvider.notifier).clearHistory();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.of(context).paddingScreenHorizontal,
          vertical: Dimens.of(context).paddingScreenVertical,
        ),
        child: historyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : historyState.errorMessage != null
              ? Center(
                  child: Text(
                    'Error: ${historyState.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : historyState.historyList.isEmpty
                  ? const Center(
                      child: Text(
                        'No history found',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Total history count: ${historyState.historyList.length}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: historyState.historyList.length,
                            itemBuilder: (context, index) {
                              final item = historyState.historyList.reversed
                                  .toList()[index];
                              return HistoryCard(history: item);
                            },
                          ),
                        ),
                      ],
                    ),
      ),
    );
  }
}
