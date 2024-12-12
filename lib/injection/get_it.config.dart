// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data_source/equipments_data_source.dart' as _i884;
import '../data_source/users_data_source.dart' as _i606;
import '../repository/equipments_repository.dart' as _i604;
import '../repository/users_repository.dart' as _i146;
import '../services/mqtt_client.dart' as _i226;
import '../store/equipments_cubit.dart' as _i269;
import '../store/login_cubit.dart' as _i299;
import '../store/scanner_cubit.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i884.EquipmentsDataSource>(
        () => _i884.EquipmentsDataSource());
    gh.lazySingleton<_i606.UsersDataSource>(() => _i606.UsersDataSource());
    gh.lazySingleton<_i226.MQTT>(() => _i226.MQTT());
    gh.lazySingleton<_i146.UsersRepository>(
        () => _i146.UsersRepository(gh<_i606.UsersDataSource>()));
    gh.factory<_i299.LoginCubit>(
        () => _i299.LoginCubit(gh<_i146.UsersRepository>()));
    gh.factory<_i1027.ScannerCubit>(
        () => _i1027.ScannerCubit(gh<_i146.UsersRepository>()));
    gh.lazySingleton<_i604.EquipmentsRepository>(
        () => _i604.EquipmentsRepository(gh<_i884.EquipmentsDataSource>()));
    gh.singleton<_i269.EquipmentsCubit>(() => _i269.EquipmentsCubit(
          gh<_i604.EquipmentsRepository>(),
          gh<_i146.UsersRepository>(),
          gh<_i226.MQTT>(),
        ));
    return this;
  }
}
