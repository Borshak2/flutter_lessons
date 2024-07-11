import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

	
final getIt = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', // default  
  preferRelativeImports: true, // default  
  asExtension: true, // default  
)  
Future<GetIt> configureDependencies() => getIt.init(); 

T inject<T extends Object>({
  String? instanceName,
}) =>
    getIt.get<T>(
      instanceName: instanceName,
    );


@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://rickandmortyapi.com/api/';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  // ignore: invalid_annotation_target
  @preResolve // if you need to pre resolve the value
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
