// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:poc_sippe_fx/core/network/api_client.dart' as _i296;
import 'package:poc_sippe_fx/core/network/dio_module.dart' as _i1072;
import 'package:poc_sippe_fx/core/settings/base_currency_store.dart' as _i200;
import 'package:poc_sippe_fx/core/settings/hive_base_currency_store.dart'
    as _i540;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i296.ApiClient>(() => _i296.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i200.BaseCurrencyStore>(
      () => _i540.HiveBaseCurrencyStore(gh<_i979.Box<String>>()),
    );
    return this;
  }
}

class _$DioModule extends _i1072.DioModule {}
