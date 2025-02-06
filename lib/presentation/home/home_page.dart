import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/theme/components/app_primary_button.dart';
import 'package:weather_app/core/theme/components/shimers/weather_card_shimer.dart';
import 'package:weather_app/presentation/home/home_page_provider.dart';
import 'package:weather_app/presentation/widgets/detailed_weather_card.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:weather_app/core/utils/city_input_validation.dart';
import 'package:weather_app/core/theme/dimens.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homePageProvider);
    final homeViewModel = ref.read(homePageProvider.notifier);

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
              const SizedBox(height: 42),
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                ),
                validator: validateCityInput,
              ),
              const SizedBox(height: 24),
              AppPrimaryButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    homeState.isCardExpanded
                        ? homeViewModel.toggleCardExpansion()
                        : null;
                    homeViewModel.fetchWeather(textController.text.trim());
                    textController.clear();
                  }
                },
                text: 'Get Weather',
              ),
              const SizedBox(height: 16),
              if (homeState.isLoading) WeatherCardShimmer(),
              if (homeState.weather != null && homeState.isLoading == false)
                GestureDetector(
                    onTap: () {
                      homeViewModel.toggleCardExpansion();
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      // Custom layout builder
                      layoutBuilder: (Widget? currentChild,
                          List<Widget> previousChildren) {
                        return Stack(
                          // Align them at the topCenter so they don't jump
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          // Align the scaling animation to the top
                          alignment: Alignment.topCenter,
                          scale: animation,
                          child: child,
                        );
                      },
                      child: homeState.isCardExpanded
                          ? DetailedWeatherCard(
                              key: const ValueKey('detailed'),
                              weather: homeState.weather!,
                              forecast: homeState.forecast,
                            )
                          : WeatherCard(
                              key: const ValueKey('compact'),
                              weather: homeState.weather!,
                            ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
