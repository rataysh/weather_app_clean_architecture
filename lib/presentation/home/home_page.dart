import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/home/home_page_provider.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:weather_app/core/utils/city_input_validation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageProvider);
    final homeViewModel = ref.read(homePageProvider.notifier);

    final textController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to history page
              context.push('/history');
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                ),
                validator: validateCityInput,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    homeViewModel.fetchWeather(textController.text.trim());
                  }
                },
                child: const Text('Get Weather'),
              ),
              const SizedBox(height: 16),
              // Loading indicator
              if (homeState.isLoading) const CircularProgressIndicator(),
              // Weather data
              if (homeState.weather != null)
                WeatherCard(weather: homeState.weather!),
            ],
          ),
        ),
      ),
    );
  }
}
