import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../application/core/extensions/extensions.dart';
import '../application/network/client/api_service.dart';
import '../application/network/client/i_api_service.dart';
import '../application/network/external-values/external_values.dart';
import '../data/local_data_source/preference/i_pref_helper.dart';
import '../data/local_data_source/preference/pref_helper.dart';
import '../data/remote_data_source/api.dart';
import '../data/remote_data_source/i_api.dart';
import '../main.dart';
import '../nav-service/i_nav_service.dart';
import '../nav-service/nav_service.dart';

final inject = GetIt.instance;

Future<void> setupLocator() async {
  HttpOverrides.global = MyHttpOverrides();
  inject.registerSingletonAsync(() => SharedPreferences.getInstance());
  inject.registerLazySingleton<INavService>(() => NavService());
  inject.registerLazySingleton<Px>(() => Px());
  inject.registerLazySingleton<IPrefHelper>(() => PrefHelper(inject()));
  inject.registerLazySingleton<IApiService>(() => ApiService.create(externalValues: ExternalValues()));
  inject.registerLazySingleton<IApi>(() => Apis(inject()));
}
