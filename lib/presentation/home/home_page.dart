import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/theme/components/app_primary_button.dart';
import 'package:weather_app/core/theme/components/shimers/weather_card_shimer.dart';
import 'package:weather_app/presentation/home/home_page_provider.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:weather_app/core/utils/city_input_validation.dart';
import 'package:weather_app/core/theme/dimens.dart';

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
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.of(context).paddingScreenHorizontal,
          vertical: Dimens.of(context).paddingScreenVertical,
        ),
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
              AppPrimaryButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    homeViewModel.fetchWeather(textController.text.trim());
                  }
                },
                text: 'Get Weather',
              ),
              const SizedBox(height: 16),
              // Loading indicator
              // if (homeState.isLoading) const CircularProgressIndicator(),
              if (homeState.isLoading) WeatherCardShimmer(),
              // Weather data
              if (homeState.weather != null && homeState.isLoading == false)
                WeatherCard(weather: homeState.weather!),
            ],
          ),
        ),
      ),
    );
  }
}
