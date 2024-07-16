// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../domain/entities/episode_entitiy.dart' as _i16;
import '../domain/entities/location_entity.dart' as _i18;
import '../domain/entities/person_entitiy.dart' as _i20;
import '../domain/service_interface/api_service.dart' as _i15;
import '../domain/service_interface/local_service.dart' as _i4;
import '../features/characters/data/dto/person_dto.dart' as _i9;
import '../features/characters/data/repository/person_repository.dart' as _i14;
import '../features/characters/data/service_impl/local_data_service_perons.dart'
    as _i10;
import '../features/characters/data/service_impl/person_api_service_impl.dart'
    as _i21;
import '../features/episodes/data/dto/episode_dto.dart' as _i7;
import '../features/episodes/data/repository/episode_repository.dart' as _i13;
import '../features/episodes/data/service_impl/api_service.dart' as _i17;
import '../features/episodes/data/service_impl/local_data_service_impl.dart'
    as _i8;
import '../features/locations/data/dto/location_dto.dart' as _i5;
import '../features/locations/data/repository/locations_repository.dart'
    as _i12;
import '../features/locations/data/service_impl/api_service.dart' as _i19;
import '../features/locations/data/service_impl/local_data_service_impl.dart'
    as _i6;
import 'locator_service.dart' as _i22;

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
    gh.lazySingleton<_i4.LocalDataService<_i5.LocationDto>>(
      () => _i6.LocalDataServiceLocationsImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServiceLocationsImpl',
    );
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i4.LocalDataService<_i7.EpisodeDto>>(
      () => _i8.LocalDataServiceEpisodesImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServiceEpisodesImpl',
    );
    gh.lazySingleton<_i4.LocalDataService<_i9.PersonDto>>(
      () => _i10.LocalDataServicePersonsImpl(
          sharedPreferences: gh<_i3.SharedPreferences>()),
      instanceName: 'LocalDataServicePersonsImpl',
    );
    gh.lazySingleton<_i11.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i12.LocationRepository>(() => _i12.LocationRepository(
          dio: gh<_i11.Dio>(),
          localService: gh<_i4.LocalDataService<_i5.LocationDto>>(
              instanceName: 'LocalDataServiceLocationsImpl'),
        ));
    gh.factory<_i13.EpisodeRepository>(() => _i13.EpisodeRepository(
          dio: gh<_i11.Dio>(),
          localService: gh<_i4.LocalDataService<_i7.EpisodeDto>>(
              instanceName: 'LocalDataServiceEpisodesImpl'),
        ));
    gh.factory<_i14.PersonRepository>(() => _i14.PersonRepository(
          dio: gh<_i11.Dio>(),
          localService: gh<_i4.LocalDataService<_i9.PersonDto>>(
              instanceName: 'LocalDataServicePersonsImpl'),
        ));
    gh.lazySingleton<_i15.RickAndMortyApiService<_i16.EpisodeEntity>>(
      () =>
          _i17.EpisodesApiServiceImpl(repository: gh<_i13.EpisodeRepository>())
            ..init(),
      instanceName: 'EpisodeService',
    );
    gh.lazySingleton<_i15.RickAndMortyApiService<_i18.LocationEntity>>(
      () => _i19.LocationsApiServiceImpl(
          repository: gh<_i12.LocationRepository>())
        ..init(),
      instanceName: 'LocationService',
    );
    gh.lazySingleton<_i15.RickAndMortyApiService<_i20.PersonEntity>>(
      () => _i21.PersonApiServiceImpl(repository: gh<_i14.PersonRepository>())
        ..init(),
      instanceName: 'PersonService',
    );
    return this;
  }
}

class _$RegisterModule extends _i22.RegisterModule {}
