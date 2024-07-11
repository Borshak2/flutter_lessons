import 'dart:convert';
import 'package:flutter_lesson_3_rick_v2/core/error/exception.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_LOCATION_LIST = 'CACHED_LOCATION_LIST';
const CACHED_LOCATION_LAST_PAGE = 'CACHED_LOCATION_LAST_PAGE';

@named
@LazySingleton(as: LocalDataService<LocationDto>)
class LocalDataServiceLocationsImpl implements LocalDataService<LocationDto> {
  
  final SharedPreferences sharedPreferences;

  LocalDataServiceLocationsImpl({required this.sharedPreferences});

  @override
  Future<void> addDtosToCache(List<LocationDto> newDtos, int page) async {
    final List<String> currentJsonLocationsList =
        sharedPreferences.getStringList(CACHED_LOCATION_LIST) ?? [];
    final List<String> newJsonLacationsList =
        newDtos.map((location) => json.encode(location.toJson())).toList();
    currentJsonLocationsList.addAll(newJsonLacationsList);
    await sharedPreferences.setStringList(
        CACHED_LOCATION_LIST, currentJsonLocationsList);
    await sharedPreferences.setInt(CACHED_LOCATION_LAST_PAGE, page);
  }

  @override
  Future<List<LocationDto>> getLastDtosFromCache() async {
    final jsonEpisodesList =
        sharedPreferences.getStringList(CACHED_LOCATION_LIST);
    if (jsonEpisodesList != null && jsonEpisodesList.isNotEmpty) {
      return jsonEpisodesList
          .map((perosonJson) => LocationDto.fromJson(json.decode(perosonJson)))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<int> getLastPage() async {
    return sharedPreferences.getInt(CACHED_LOCATION_LAST_PAGE) ?? 0;
  }
  
  @override
  Future<List<String>> getListQueries() {
    // TODO: implement getListQueries
    throw UnimplementedError();
  }
  
  @override
  Future<void> queriesToCache(String queries) {
    // TODO: implement queriesToCache
    throw UnimplementedError();
  }
  

}
