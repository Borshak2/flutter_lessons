import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/service_impl/local_data_service_perons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalDataSource Tests', () {
    setUp(() {
      final Map<String, Object> values = <String, Object>{};
      SharedPreferences.setMockInitialValues(values);
    });

    final Map<String, dynamic> jsonPerson = {
      "id": 361,
      "name": "Toxic Rick",
      "status": "Dead",
      "species": "Humanoid",
      "type": "Rick's Toxic Side",
      "gender": "Male",
      "origin": {
        "name": "Alien Spa",
        "url": "https://rickandmortyapi.com/api/location/64"
      },
      "location": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/20"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
      "episode": ["https://rickandmortyapi.com/api/episode/27"],
      "url": "https://rickandmortyapi.com/api/character/361",
      "created": "2018-01-10T18:20:41.703Z"
    };

    final Map<String, dynamic> jsonPerson2 = {
      "id": 21,
      "name": "Rick",
      "status": "Dead",
      "species": "Humanoid",
      "type": "Rick's",
      "gender": "Male",
      "origin": {
        "name": "Alien Spa",
        "url": "https://rickandmortyapi.com/api/location/64"
      },
      "location": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/20"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
      "episode": ["https://rickandmortyapi.com/api/episode/27"],
      "url": "https://rickandmortyapi.com/api/character/361",
      "created": "2018-01-10T18:20:41.703Z"
    };

    List<PersonDto> expectedPersonsList = [
      PersonDto.fromJson(jsonPerson),
      PersonDto.fromJson(jsonPerson2)
    ];

    test('Add and Retrieve Persons from Cache', () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      LocalDataServicePersonsImpl service =
          LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);

      await service.addDtosToCache([PersonDto.fromJson(jsonPerson)], 1);
      await service.addDtosToCache([PersonDto.fromJson(jsonPerson2)], 2);

      final cachedPersonsList = await service.getLastDtosFromCache();
      expect(cachedPersonsList, expectedPersonsList);
    });

    test('Retrieve Last Cached Page', () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      LocalDataServicePersonsImpl service =
          LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);

      await service.addDtosToCache([PersonDto.fromJson(jsonPerson)], 1);
      await service.addDtosToCache([PersonDto.fromJson(jsonPerson2)], 2);

      final lastCachedPage = await service.getLastPage();
      expect(lastCachedPage, 2);
    });
  });
}
