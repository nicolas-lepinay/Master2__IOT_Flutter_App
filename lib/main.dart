import 'package:arduino_iot_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arduino_iot_app/widgets/counter_page.dart';
import 'package:arduino_iot_app/store/counter_cubit.dart';
import 'package:arduino_iot_app/router/router.dart';

// Externes
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Désactivation du mode "paysage" :
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /*
  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("671f4ced001f0d3aeabf");
  Account account = Account(client);
*/

  runApp(
    BlocProvider(
      create: (context) => CounterCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //fontFamily: 'Satoshi',
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Constants.lightGrey,
      ),
      //home: const MyHomePage(title: "Test avec Cubit"),
      routerConfig: router,
    );
  }
}
