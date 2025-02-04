import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/history/history_page.dart';
import 'package:weather_app/presentation/home/home_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryPage(),
    ),
  ],
);
