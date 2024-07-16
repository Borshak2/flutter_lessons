import 'package:dio/dio.dart';
import 'package:flutter_lesson_3_rick_v2/core/error/exceptions.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/mapper/episode_mapper.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/service_impl/local_data_service_impl.dart';
import 'package:injectable/injectable.dart';

enum EpisodeFilter { name, episode }

@singleton 
class EpisodeRepository {
  final Map<EpisodeFilter, String> _filters = {
    EpisodeFilter.name: '?name=',
    EpisodeFilter.episode: '?episode=',
  };

  final String _endpoint = 'episode/';
  final Dio _dio;
  final LocalDataService _localService;

  EpisodeRepository({
    required Dio dio,
    // required LocalDataService localService,
    @Named.from(LocalDataServiceEpisodesImpl)
    required LocalDataService<EpisodeDto> localService,
  })  : _dio = dio,
        _localService = localService;

  Future<List<EpisodeEntity>> fetchAllData() async {
    try {
      final response = await _dio.get(_endpoint);
      return _processResponseAndCache(response, 1);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<int> getLastPage() async {
    return await _localService.getLastPage();
  }

  Future<List<String>> getQuerisList() async {
    return await _localService.getCachedQueries();
  }

  Future<List<EpisodeEntity>> fetchEpisodesByPage(int page) async {
    final lastCachedPage = await _localService.getLastPage();
    if (lastCachedPage <= page) {
      try {
        final response = await _dio.get('$_endpoint?page=$page');
        return _processResponseAndCache(response, page);
      } catch (e) {
        throw ServerException();
      }
    } else {
      print('Fetching local data');
      final cachedDtos =
          await _localService.getLastDtosFromCache() as List<EpisodeDto>;
      return _parseEpisodeDtos(cachedDtos);
    }
  }

  Future<List<EpisodeEntity>> fetchDataByFilter(
      EpisodeFilter filter, String data) async {
    try {
      _localService.cacheQuery(data);
      final filterValue = _filters[filter]!;
      final response = await _dio.get('$_endpoint$filterValue$data');
      return _processResponseAndCache(response, 1);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<EpisodeEntity> fetchDataByUrl(String url) async {
    try {
      final response = await _dio.getUri(Uri.parse(url));
      final dto = EpisodeDto.fromJson(response.data as Map<String, dynamic>);
      return EpisodeMapper.toEntity(dto);
    } catch (e) {
      throw ServerException();
    }
  }

  List<EpisodeEntity> _parseEpisodeDtos(List<EpisodeDto> dtos) {
    return dtos.map((dto) => EpisodeMapper.toEntity(dto)).toList();
  }

  Future<List<EpisodeEntity>> _processResponseAndCache(
      Response response, int page) async {
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            response.data['results'] as List<dynamic>;
        final List<EpisodeDto> dtos =
            jsonData.map((json) => EpisodeDto.fromJson(json)).toList();
        await _localService.addDtosToCache(dtos, page);
        return _parseEpisodeDtos(dtos);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
