import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:arduino_iot_app/injection/get_it.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => await getIt.init();
