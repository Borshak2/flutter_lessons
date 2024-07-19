// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../domain/entities/episode_entitiy.dart' as _i17;
import '../domain/entities/location_entity.dart' as _i19;
import '../domain/entities/person_entitiy.dart' as _i21;
import '../domain/service_interface/api_service.dart' as _i16;
import '../domain/service_interface/local_service.dart' as _i5;
import '../features/characters/data/dto/person_dto.dart' as _i10;
import '../features/characters/data/repository/person_repository.dart' as _i15;
import '../features/characters/data/service_impl/local_data_service_perons.dart'
    as _i11;
import '../features/characters/data/service_impl/person_api_service_impl.dart'
    as _i22;
import '../features/episodes/data/dto/episode_dto.dart' as _i8;
import '../features/episodes/data/repository/episode_repository.dart' as _i14;
import '../features/episodes/data/service_impl/api_service.dart' as _i18;
import '../features/episodes/data/service_impl/local_data_service_impl.dart'
    as _i9;
import '../features/locations/data/dto/location_dto.dart' as _i6;
import '../features/locations/data/repository/locations_repository.dart'
    as _i13;
import '../features/locations/data/service_impl/api_service.dart' as _i20;
import '../features/locations/data/service_impl/local_data_service_impl.dart'
    as _i7;
import '../router/app_router.dart' as _i4;
import 'locator_service.dart' as _i23;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.LocalDataService<_i6.LocationDto>>(
      () => _i7.LocalDataServiceLocationsImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServiceLocationsImpl',
    );
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i5.LocalDataService<_i8.EpisodeDto>>(
      () => _i9.LocalDataServiceEpisodesImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServiceEpisodesImpl',
    );
    gh.lazySingleton<_i5.LocalDataService<_i10.PersonDto>>(
      () => _i11.LocalDataServicePersonsImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServicePersonsImpl',
    );
    gh.lazySingleton<_i12.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i13.LocationRepository>(() => _i13.LocationRepository(
          dio: gh<_i12.Dio>(),
          localService: gh<_i5.LocalDataService<_i6.LocationDto>>(
              instanceName: 'LocalDataServiceLocationsImpl'),
        ));
    gh.singleton<_i14.EpisodeRepository>(() => _i14.EpisodeRepository(
          dio: gh<_i12.Dio>(),
          localService: gh<_i5.LocalDataService<_i8.EpisodeDto>>(
              instanceName: 'LocalDataServiceEpisodesImpl'),
        ));
    gh.singleton<_i15.PersonRepository>(() => _i15.PersonRepository(
          dio: gh<_i12.Dio>(),
          localService: gh<_i5.LocalDataService<_i10.PersonDto>>(
              instanceName: 'LocalDataServicePersonsImpl'),
        ));
    gh.lazySingleton<_i16.RickAndMortyApiService<_i17.EpisodeEntity>>(
      () =>
          _i18.EpisodesApiServiceImpl(repository: gh<_i14.EpisodeRepository>())
            ..init(),
      instanceName: 'EpisodeService',
    );
    gh.lazySingleton<_i16.RickAndMortyApiService<_i19.LocationEntity>>(
      () => _i20.LocationsApiServiceImpl(
          repository: gh<_i13.LocationRepository>())
        ..init(),
      instanceName: 'LocationService',
    );
    gh.lazySingleton<_i16.RickAndMortyApiService<_i21.PersonEntity>>(
      () => _i22.PersonApiServiceImpl(repository: gh<_i15.PersonRepository>())
        ..init(),
      instanceName: 'PersonService',
    );
    return this;
  }
}

class _$RegisterModule extends _i23.RegisterModule {}
