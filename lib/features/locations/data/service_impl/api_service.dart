import 'dart:async';

import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/repository/locations_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@Named("LocationService")
@LazySingleton(as: RickAndMortyApiService<LocationEntity>)
class LocationsApiServiceImpl
    implements RickAndMortyApiService<LocationEntity> {
  late int pageNumber;
  final LocationRepository repository;

  LocationsApiServiceImpl({required this.repository});

  final _locationList = BehaviorSubject<List<LocationEntity>>();

  @override
  Stream<List<LocationEntity>> get getterEntitiesStream => _locationList.stream;
  @override
  List<LocationEntity> get getterEntitiesList =>
      _locationList.valueOrNull ?? [];

  @PostConstruct()
  void init() async {
    final newPage = await repository.getLastPage();
    pageNumber = newPage == 0 ? 1 : newPage;
    final locations = await fetchAndCacheEntityByPage(pageNumber);
    _locationList.add(locations);
  }

  @override
  void updateData() async {
    final newLocations = await fetchAndCacheEntityByPage(pageNumber);
    final currentLocations = _locationList.valueOrNull ?? [];
    _locationList.add(currentLocations + newLocations);
  }

  @override
  Future<List<LocationEntity>> fetchAndCacheEntityByPage(int page) async {
    pageNumber++;
    return await repository.fetchLocationsByPage(page);
  }

  @override
  Future<List<LocationEntity>> fetchEntityByUrls(List<String> listUrl) async {
    return [];
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return await repository.getQueriesList();
  }

  @override
  Future<List<LocationEntity>> searchEntity(String query) async {
    return await repository.fetchDataByFilter(LocationsFilter.name, query);
  }
}
