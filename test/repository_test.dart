import 'package:dio/dio.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/repository/person_repository.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/service_impl/local_data_service_perons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
 setUpAll(() async {
    final Map<String, Object> values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });
  ////local
  // setUpAll(() async {
  //   final Map<String, Object> values = <String, Object>{
  //     'CACHED_PERSONS_LAST_PAGE': 2,
  //     'CACHED_PERSONS_LIST': ['''{
  //       "id": 361,
  //       "name": "Toxic Rick",
  //       "status": "Dead",
  //       "species": "Humanoid",
  //       "type": "Rick's Toxic Side",
  //       "gender": "Male",
  //       "origin": {
  //         "name": "Alien Spa",
  //         "url": "https://rickandmortyapi.com/api/location/64"
  //       },
  //       "location": {
  //         "name": "Earth",
  //         "url": "https://rickandmortyapi.com/api/location/20"
  //       },
  //       "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
  //       "episode": [
  //         "https://rickandmortyapi.com/api/episode/27"
  //       ],
  //       "url": "https://rickandmortyapi.com/api/character/361",
  //       "created": "2018-01-10T18:20:41.703Z"
  //     }'''],
  //   };
  //   SharedPreferences.setMockInitialValues(values);
  // });

 

 test('fetchDataByFilter returns ', () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocalDataServicePersonsImpl service = LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);
    final dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'));
    final personRepository = PersonRepository(dio: dio, localService: service);

    final personByPage = await personRepository.fetchCharactersByPage(1);

    expect(personByPage, isA<List<PersonEntity>>());
    if (personByPage.isNotEmpty) {
      expect(personByPage.first, isA<PersonEntity>());
    }
  });


  test('fetchDataByPage returns a list of PersonEntity', () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocalDataServicePersonsImpl service = LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);
    final dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'));
    final personRepository = PersonRepository(dio: dio, localService: service);
    final personsFromSearh =  await personRepository.fetchDataByFilter(PersonFilter.name, 'Rick');
    final lastSearch = await personRepository.getSearchHistory();
    print(personsFromSearh);
    expect(lastSearch.first, 'Rick');
 
  });

  test('fetchDataByUrl returns a PersonEntity', () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocalDataServicePersonsImpl service = LocalDataServicePersonsImpl(sharedPreferences: sharedPreferences);
    final dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'));
    final personRepository = PersonRepository(dio: dio, localService: service);

    final personByUrl = await personRepository.fetchDataByUrl('https://rickandmortyapi.com/api/character/1');

    expect(personByUrl, isA<PersonEntity>());
  });
}