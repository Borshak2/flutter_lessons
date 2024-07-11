import 'dart:convert';
import 'package:flutter_lesson_3_rick_v2/core/error/exception.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';
const CACHED_PERSONS_LAST_PAGE = 'CACHED_PERSONS_LAST_PAGE';
const CACHED_QUERIES_LIST = 'CACHED_QUERIES_LIST';

@named
@LazySingleton(as: LocalDataService<PersonDto>)
class LocalDataServicePersonsImpl implements LocalDataService<PersonDto> {
  final SharedPreferences sharedPreferences;

  LocalDataServicePersonsImpl({required this.sharedPreferences});

  @override
  Future<void> addDtosToCache(List<PersonDto> newDtos, int page) async {
    final List<String> currentJsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
    final List<String> newJsonPersonsList =
        newDtos.map((person) => json.encode(person.toJson())).toList();
    currentJsonPersonsList.addAll(newJsonPersonsList);
    await sharedPreferences.setStringList(
        CACHED_PERSONS_LIST, currentJsonPersonsList);
    await sharedPreferences.setInt(CACHED_PERSONS_LAST_PAGE, page);
  }

  @override
  Future<List<PersonDto>> getLastDtosFromCache() async {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList != null && jsonPersonsList.isNotEmpty) {
      return jsonPersonsList
          .map((perosonJson) => PersonDto.fromJson(json.decode(perosonJson)))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<int> getLastPage() async {
    return sharedPreferences.getInt(CACHED_PERSONS_LAST_PAGE) ?? 0;
  }

  @override
  Future<List<String>> getListQueries() async {
    return sharedPreferences.getStringList(CACHED_QUERIES_LIST) ?? [];
  }

  @override
  Future<void> queriesToCache(String query) async {
    final queriesList = sharedPreferences.getStringList(CACHED_QUERIES_LIST) ?? [];
    queriesList.add(query);
    await sharedPreferences.setStringList(CACHED_QUERIES_LIST, queriesList);
  }
}
