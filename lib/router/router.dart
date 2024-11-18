import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Pages
import 'package:arduino_iot_app/widgets/pages/landing_page.dart';
import 'package:arduino_iot_app/widgets/pages/home_page.dart';

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LandingPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
    ),
  ],
);
