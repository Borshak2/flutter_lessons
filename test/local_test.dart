import 'dart:convert';
import 'package:flutter_lesson_3_rick_v2/core/error/exceptions.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/service_impl/local_data_service_perons.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/service_impl/local_data_service_impl.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/service_impl/local_data_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late LocalDataServiceLocationsImpl localDataServiceLocations;
  late LocalDataServiceEpisodesImpl localDataServiceEpisodes;
  late LocalDataServicePersonsImpl localDataServicePersons;

  setUpAll(() {
    final Map<String, Object> values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });

  setUp(() async {
    sharedPreferences = await SharedPreferences.getInstance();
    localDataServiceLocations =
        LocalDataServiceLocationsImpl(sharedPreferences: sharedPreferences);
    localDataServiceEpisodes =
        LocalDataServiceEpisodesImpl(sharedPreferences: sharedPreferences);
    localDataServicePersons =
        LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);
  });

  group('LocalDataServiceLocationsImpl', () {
    test('should add locations to cache and set last page', () async {
      final List<LocationDto> locations = [
        LocationDto(
            id: 1,
            name: 'Earth',
            type: 'Planet',
            dimension: 'C-137',
            residents: [],
            url: 'https://rickandmortyapi.com/api/location/1',
            created: '2017-11-10T12:42:04.162Z'),
        LocationDto(
            id: 2,
            name: 'Abadango',
            type: 'Cluster',
            dimension: 'unknown',
            residents: [],
            url: 'https://rickandmortyapi.com/api/location/2',
            created: '2017-11-10T13:06:38.182Z'),
      ];

      await localDataServiceLocations.addDtosToCache(locations, 1);

      final List<String> cachedLocations =
          sharedPreferences.getStringList(CACHED_LOCATION_LIST) ?? [];
      final int lastPage =
          sharedPreferences.getInt(CACHED_LOCATION_LAST_PAGE) ?? 0;

      expect(cachedLocations, isNotEmpty);
      expect(cachedLocations.length, locations.length);
      expect(lastPage, 1);
    });

    test('should return last locations from cache', () async {
      final List<String> jsonLocations = [
        json.encode({
          'id': 1,
          'name': 'Earth',
          'type': 'Planet',
          'dimension': 'C-137',
          'residents': [],
          'url': 'https://rickandmortyapi.com/api/location/1',
          'created': '2017-11-10T12:42:04.162Z',
        }),
        json.encode({
          'id': 2,
          'name': 'Abadango',
          'type': 'Cluster',
          'dimension': 'unknown',
          'residents': [],
          'url': 'https://rickandmortyapi.com/api/location/2',
          'created': '2017-11-10T13:06:38.182Z',
        }),
      ];

      await sharedPreferences.setStringList(
          CACHED_LOCATION_LIST, jsonLocations);

      final result = await localDataServiceLocations.getLastDtosFromCache();

      expect(result, isA<List<LocationDto>>());
      expect(result.length, jsonLocations.length);
      expect(result.first.id, 1);
    });

    test('should throw CacheException when there are no locations in cache',
        () async {
      await sharedPreferences.remove(CACHED_LOCATION_LIST);

      expect(() => localDataServiceLocations.getLastDtosFromCache(),
          throwsA(isA<CacheException>()));
    });

    test('should return last cached page', () async {
      await sharedPreferences.setInt(CACHED_LOCATION_LAST_PAGE, 3);

      final lastPage = await localDataServiceLocations.getLastPage();

      expect(lastPage, 3);
    });

    test('should return 0 when there is no last cached page', () async {
      await sharedPreferences.remove(CACHED_LOCATION_LAST_PAGE);

      final lastPage = await localDataServiceLocations.getLastPage();

      expect(lastPage, 0);
    });
  });

  group('LocalDataServiceEpisodesImpl', () {
    test('should add episodes to cache and set last page', () async {
      final List<EpisodeDto> episodes = [
        EpisodeDto(
          id: 1,
          name: 'Pilot',
          airDate: 'December 2, 2013',
          episode: 'S01E01',
          characters: [],
          url: 'https://rickandmortyapi.com/api/episode/1',
        ),
        EpisodeDto(
          id: 2,
          name: 'Lawnmower Dog',
          airDate: 'December 9, 2013',
          episode: 'S01E02',
          characters: [],
          url: 'https://rickandmortyapi.com/api/episode/2',
        ),
      ];

      await localDataServiceEpisodes.addDtosToCache(episodes, 1);

      final List<String> cachedEpisodes =
          sharedPreferences.getStringList(CACHED_EPISODE_LIST) ?? [];
      final int lastPage =
          sharedPreferences.getInt(CACHED_EPISODE_LAST_PAGE) ?? 0;

      expect(cachedEpisodes, isNotEmpty);
      expect(cachedEpisodes.length, episodes.length);
      expect(lastPage, 1);
    });

    test('should return last episodes from cache', () async {
      final List<String> jsonEpisodes = [
        json.encode({
          'id': 1,
          'name': 'Pilot',
          'air_date': 'December 2, 2013',
          'episode': 'S01E01',
          'characters': [],
          'url': 'https://rickandmortyapi.com/api/episode/1',
          'created': '2017-11-10T12:56:33.798Z',
        }),
        json.encode({
          'id': 2,
          'name': 'Lawnmower Dog',
          'air_date': 'December 9, 2013',
          'episode': 'S01E02',
          'characters': [],
          'url': 'https://rickandmortyapi.com/api/episode/2',
          'created': '2017-11-10T12:56:33.916Z',
        }),
      ];

      await sharedPreferences.setStringList(CACHED_EPISODE_LIST, jsonEpisodes);

      final result = await localDataServiceEpisodes.getLastDtosFromCache();

      expect(result, isA<List<EpisodeDto>>());
      expect(result.length, jsonEpisodes.length);
      expect(result.first.id, 1);
    });

    test('should throw CacheException when there are no episodes in cache',
        () async {
      await sharedPreferences.remove(CACHED_EPISODE_LIST);

      expect(() => localDataServiceEpisodes.getLastDtosFromCache(),
          throwsA(isA<CacheException>()));
    });

    test('should return last cached page', () async {
      await sharedPreferences.setInt(CACHED_EPISODE_LAST_PAGE, 3);

      final lastPage = await localDataServiceEpisodes.getLastPage();

      expect(lastPage, 3);
    });

    test('should return 0 when there is no last cached page', () async {
      await sharedPreferences.remove(CACHED_EPISODE_LAST_PAGE);

      final lastPage = await localDataServiceEpisodes.getLastPage();

      expect(lastPage, 0);
    });
  });

  group('LocalDataServicePersonsImpl', () {
    test('should add persons to cache and set last page', () async {
      const locationMap = <String, dynamic>{
        "name": "Alien Spa",
        "url": "https://rickandmortyapi.com/api/location/64"
      };
      final List<PersonDto> persons = [
        PersonDto(
            id: 1,
            name: 'Rick Sanchez',
            status: 'Alive',
            species: 'Human',
            type: '',
            gender: 'Male',
            origin: locationMap,
            location: locationMap,
            image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            episode: [],
            url: 'https://rickandmortyapi.com/api/character/1',
            created: DateTime.parse('2017-11-04T18:48:46.250Z')),
        PersonDto(
            id: 2,
            name: 'Morty Smith',
            status: 'Alive',
            species: 'Human',
            type: '',
            gender: 'Male',
            origin: locationMap,
            location: locationMap,
            image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
            episode: [],
            url: 'https://rickandmortyapi.com/api/character/2',
            created: DateTime.parse('2017-11-04T18:48:46.250Z')),
      ];

      await localDataServicePersons.addDtosToCache(persons, 1);

      final List<String> cachedPersons =
          sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
      final int lastPage =
          sharedPreferences.getInt(CACHED_PERSONS_LAST_PAGE) ?? 0;

      expect(cachedPersons, isNotEmpty);
      expect(cachedPersons.length, persons.length);
      expect(lastPage, 1);
    });

    test('should return last persons from cache', () async {
      const locationMap = <String, dynamic>{
        "name": "Alien Spa",
        "url": "https://rickandmortyapi.com/api/location/64"
      };
      final List<String> jsonPersons = [
        json.encode({
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'origin': locationMap,
          'location': locationMap,
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'episode': [],
          'url': 'https://rickandmortyapi.com/api/character/1',
          'created': '2017-11-04T18:48:46.250Z',
        }),
        json.encode({
          'id': 2,
          'name': 'Morty Smith',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'origin': locationMap,
          'location': locationMap,
          'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
          'episode': [],
          'url': 'https://rickandmortyapi.com/api/character/2',
          'created': '2017-11-04T18:50:21.651Z',
        }),
      ];

      await sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersons);

      final result = await localDataServicePersons.getLastDtosFromCache();

      expect(result, isA<List<PersonDto>>());
      expect(result.length, jsonPersons.length);
      expect(result.first.id, 1);
    });

    test('should throw CacheException when there are no persons in cache',
        () async {
      await sharedPreferences.remove(CACHED_PERSONS_LIST);

      expect(() => localDataServicePersons.getLastDtosFromCache(),
          throwsA(isA<CacheException>()));
    });

    test('should return last cached page', () async {
      await sharedPreferences.setInt(CACHED_PERSONS_LAST_PAGE, 3);

      final lastPage = await localDataServicePersons.getLastPage();

      expect(lastPage, 3);
    });

    test('should return 0 when there is no last cached page', () async {
      await sharedPreferences.remove(CACHED_PERSONS_LAST_PAGE);

      final lastPage = await localDataServicePersons.getLastPage();

      expect(lastPage, 0);
    });
  });
}
