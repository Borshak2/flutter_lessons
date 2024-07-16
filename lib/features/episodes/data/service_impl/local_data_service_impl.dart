import 'dart:convert';
import 'package:flutter_lesson_3_rick_v2/core/error/exceptions.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_EPISODE_LIST = 'CACHED_EPISODE_LIST';
const CACHED_EPISODE_LAST_PAGE = 'CACHED_EPISODE_LAST_PAGE';
const CACHED_EPIOSDE_QUERIES_LIST = 'CACHED_EPIOSDE_QUERIES_LIST';

@named
@LazySingleton(as: LocalDataService<EpisodeDto>)
class LocalDataServiceEpisodesImpl implements LocalDataService<EpisodeDto> {
  final SharedPreferences sharedPreferences;

  LocalDataServiceEpisodesImpl({required this.sharedPreferences});

  @override
  Future<void> addDtosToCache(List<EpisodeDto> newDtos, int page) async {
    final List<String> currentJsonEpisodesList =
        sharedPreferences.getStringList(CACHED_EPISODE_LIST) ?? [];
    final List<String> newjsonEpisodesList =
        newDtos.map((episode) => json.encode(episode.toJson())).toList();
    currentJsonEpisodesList.addAll(newjsonEpisodesList);
    await sharedPreferences.setStringList(
        CACHED_EPISODE_LIST, currentJsonEpisodesList);
    await sharedPreferences.setInt(CACHED_EPISODE_LAST_PAGE, page);
  }

  @override
  Future<List<EpisodeDto>> getLastDtosFromCache() async {
    final jsonEpisodesList =
        sharedPreferences.getStringList(CACHED_EPISODE_LIST);
    if (jsonEpisodesList != null && jsonEpisodesList.isNotEmpty) {
      return jsonEpisodesList
          .map((perosonJson) => EpisodeDto.fromJson(json.decode(perosonJson)))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<int> getLastPage() async {
    return sharedPreferences.getInt(CACHED_EPISODE_LAST_PAGE) ?? 0;
  }

  @override
  Future<void> cacheQuery(String query) async {
    final queryList =
        sharedPreferences.getStringList(CACHED_EPIOSDE_QUERIES_LIST) ?? [];
    queryList.add(query);
    sharedPreferences.setStringList(CACHED_EPIOSDE_QUERIES_LIST, queryList);
  }

  @override
  Future<List<String>> getCachedQueries() async {
    return sharedPreferences.getStringList(CACHED_EPIOSDE_QUERIES_LIST) ?? [];
  }
}
