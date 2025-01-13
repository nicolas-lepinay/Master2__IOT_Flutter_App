import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:arduino_iot_app/injection/get_it.dart';

// Pages
import 'package:arduino_iot_app/widgets/pages/login_page.dart';
import 'package:arduino_iot_app/widgets/pages/home_page.dart';
import 'package:arduino_iot_app/widgets/pages/details_page.dart';
import 'package:arduino_iot_app/widgets/pages/qr_code_scanner.dart';
import 'package:arduino_iot_app/widgets/pages/users_selection_page.dart';

// Models
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/models/schema/user.dart';

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        final equipment = state.extra as Equipment;
        return DetailsPage(equipment: equipment);
      },
    ),
    GoRoute(
      path: '/qrcode-scanner',
      builder: (BuildContext context, GoRouterState state) {
        return QRCodeScanner();
      },
    ),
    GoRoute(
      path: '/users-selection',
      builder: (BuildContext context, GoRouterState state) {
        /*
        final extraMap = state.extra as Map<String, dynamic>; // Cast to Map
        final users = extraMap['users'] as List<User>;
        */
        return const UsersSelectionPage();
      },
    )
  ],
);
