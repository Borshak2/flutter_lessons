import 'package:dio/dio.dart';
import 'package:flutter_lesson_3_rick_v2/core/error/exception.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/local_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/mapper/location_mapper.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/service_impl/local_data_service_impl.dart';
import 'package:injectable/injectable.dart';


enum LocationsFilter { name, type, dimension}

@injectable
class LocationRepository {
  final Map<LocationsFilter, String> _filters = {
    LocationsFilter.name: '?name=',
    LocationsFilter.type: '?type=',
    LocationsFilter.dimension: '?dimension=',
  };

  final String _endpoint = 'location/';
  final Dio _dio;
  final LocalDataService _localService;

  LocationRepository({
    required Dio dio,
    // required LocalDataService localService,
    @Named.from(LocalDataServiceLocationsImpl) required LocalDataService<LocationDto> localService,
  }) : _dio = dio,
       _localService = localService;

  Future<List<LocationEntity>> fetchAllData() async {
    try {
      final response = await _dio.get(_endpoint);
      return _processResponseAndCache(response, 1);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<int> getLastPage() async{
    return await _localService.getLastPage();
  }  

  Future<List<LocationEntity>> fetchLocationsByPage(int page) async {
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
      final cachedDtos = await _localService.getLastDtosFromCache() as List<LocationDto>;
      return _parseLocationDtos(cachedDtos);
    }
  }

  Future<List<LocationEntity>> fetchDataByFilter(
      LocationsFilter filter, String data) async {
    try {
      final filterValue = _filters[filter]!;
      final response = await _dio.get('$_endpoint$filterValue$data');
      return _processResponseAndCache(response, 1);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<LocationEntity> fetchDataByUrl(String url) async {
    try {
      final response = await _dio.getUri(Uri.parse(url));
      final dto = LocationDto.fromJson(response.data as Map<String, dynamic>);
      return LocationMapper.toEntity(dto);
    } catch (e) {
      throw ServerException();
    }
  }

  

  List<LocationEntity> _parseLocationDtos(List<LocationDto> dtos) {
    return dtos.map((dto) => LocationMapper.toEntity(dto)).toList();
  }

  

  Future<List<LocationEntity>> _processResponseAndCache(Response response, int page) async {
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['results'] as List<dynamic>;
        final List<LocationDto> dtos = jsonData.map((json) => LocationDto.fromJson(json)).toList();
        await _localService.addDtosToCache(dtos, page);
        return _parseLocationDtos(dtos);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}



