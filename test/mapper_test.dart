import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/mapper/person_mapper.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/mapper/episode_mapper.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/mapper/location_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main()async{

  group('MapeerTest', (){
    final dio = Dio();
  
    test('PersonMapper', ()async{
      final response = await dio.get('https://rickandmortyapi.com/api/character/2');
      final json = response.data as Map<String, dynamic>;
      final dto = PersonDto.fromJson(json);
      final entity = PersonMapper.toEntity(dto);
      final resaultDto = PersonMapper.fromEntity(entity);
      expect(dto, resaultDto);
    });
    test('LocationMapper', ()async{
      final response = await dio.get('https://rickandmortyapi.com/api/location/23');
      final json = response.data as Map<String, dynamic>;
      final dto = LocationDto.fromJson(json);
      final entity = LocationMapper.toEntity(dto);
      final resaultDto = LocationMapper.fromEntity(entity);
      expect(dto, resaultDto);
    });
    test('EpisodeMapper', ()async{
      final response = await dio.get('https://rickandmortyapi.com/api/episode/1');
      final json = response.data as Map<String, dynamic>;
      final dto = EpisodeDto.fromJson(json);
      final entity = EpisodeMapper.toEntity(dto);
      final resaultDto = EpisodeMapper.fromEntity(entity);
      expect(dto, resaultDto);
    });
  });
}