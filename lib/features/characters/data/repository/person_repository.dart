import 'package:dio/dio.dart';
import 'package:flutter_lesson_3_rick_v2/core/error/exceptions.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/mapper/person_mapper.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/service_impl/local_data_service_perons.dart';
import 'package:injectable/injectable.dart';

enum PersonFilter { name, status, species, type, gender }

@injectable
class PersonRepository {
  final Map<PersonFilter, String> _filters = {
    PersonFilter.name: '?name=',
    PersonFilter.status: '?status=',
    PersonFilter.species: '?species=',
    PersonFilter.type: '?type=',
    PersonFilter.gender: '?gender=',
  };

  final String _endpoint = 'character/';
  final Dio _dio;
  final LocalDataService<PersonDto> _localService;

  PersonRepository({
    required Dio dio,
    @Named.from(LocalDataServicePersonsImpl)
    required LocalDataService<PersonDto> localService,
  })  : _dio = dio,
        _localService = localService;

  Future<int> getLastPage() async {
    return await _localService.getLastPage();
  }

  Future<List<PersonEntity>> fetchAllData() async {
    try {
      final response = await _dio.get(_endpoint);
      return _processResponseAndCache(response, 1);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<PersonEntity>> fetchCharactersByPage(int page) async {
    final lastCachedPage = await _localService.getLastPage();
    if (lastCachedPage <= page) {
      try {
        final response = await _dio.get('$_endpoint?page=$page');
        return _processResponseAndCache(response, page);
      } catch (e) {
        throw ServerException();
      }
    } else {
      final cachedDtos =
          _localService.getLastDtosFromCache() as List<PersonDto>;
      return _parseCharacterDtos(cachedDtos);
    }
  }

  Future<List<PersonEntity>> fetchDataByFilter(
      PersonFilter filter, String data) async {
    try {
      final filterValue = _filters[filter]!;
      final response = await _dio.get('$_endpoint$filterValue$data');
      return _parseResponse(response, data);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<String>> getSearchHistory() async {
    return await _localService.getCachedQueries();
  }

  Future<PersonEntity> fetchDataByUrl(String url) async {
    try {
      final response = await _dio.getUri(Uri.parse(url));
      final dto = PersonDto.fromJson(response.data as Map<String, dynamic>);
      return PersonMapper.toEntity(dto);
    } catch (e) {
      throw ServerException();
    }
  }

  List<PersonEntity> _parseCharacterDtos(List<PersonDto> dtos) {
    return dtos.map((dto) => PersonMapper.toEntity(dto)).toList();
  }

  Future<List<PersonEntity>> _processResponseAndCache(
      Response response, int page) async {
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            response.data['results'] as List<dynamic>;
        final List<PersonDto> dtos =
            jsonData.map((json) => PersonDto.fromJson(json)).toList();
        await _localService.addDtosToCache(dtos, page);
        return _parseCharacterDtos(dtos);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  List<PersonEntity> _parseResponse(Response response, String query) {
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data['results'] as List<dynamic>;
      final List<PersonDto> dtos =
          jsonData.map((json) => PersonDto.fromJson(json)).toList();
      _localService.cacheQuery(query);
      return _parseCharacterDtos(dtos);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
