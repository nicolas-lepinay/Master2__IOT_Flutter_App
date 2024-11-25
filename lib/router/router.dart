import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Pages
import 'package:arduino_iot_app/widgets/pages/landing_page.dart';
import 'package:arduino_iot_app/widgets/pages/home_page.dart';
import 'package:arduino_iot_app/widgets/pages/details_page.dart';

// Models
import 'package:arduino_iot_app/models/schema/equipment.dart';

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LandingPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        final equipment = state.extra as Equipment;
        return DetailsPage(equipment: equipment);
      },
    ),
  ],
);
