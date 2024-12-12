import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:arduino_iot_app/injection/get_it.dart';

// Pages
import 'package:arduino_iot_app/widgets/pages/login_page.dart';
import 'package:arduino_iot_app/widgets/pages/home_page.dart';
import 'package:arduino_iot_app/widgets/pages/details_page.dart';
import 'package:arduino_iot_app/widgets/pages/qr_code_scanner.dart';

// Models
import 'package:arduino_iot_app/models/schema/equipment.dart';

// Cubit
import 'package:arduino_iot_app/store/login_cubit.dart';

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
        /*
        return BlocProvider<LoginCubit>(
          create: (_) => getIt<LoginCubit>(),
          child: LandingPage(),
        );
         */
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
  ],
);
