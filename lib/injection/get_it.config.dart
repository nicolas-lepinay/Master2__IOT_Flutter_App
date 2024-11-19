// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data_source/global_data_source.dart' as _i233;
import '../repository/global_repository.dart' as _i461;
import '../services/mqtt_client.dart' as _i226;
import '../store/equipments_cubit.dart' as _i269;

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
    gh.lazySingleton<_i233.GlobalDataSource>(() => _i233.GlobalDataSource());
    gh.lazySingleton<_i226.MQTT>(() => _i226.MQTT());
    gh.lazySingleton<_i461.GlobalRepository>(
        () => _i461.GlobalRepository(gh<_i233.GlobalDataSource>()));
    gh.lazySingleton<_i269.EquipmentsCubit>(() => _i269.EquipmentsCubit(
          gh<_i461.GlobalRepository>(),
          gh<_i226.MQTT>(),
        ));
    return this;
  }
}
