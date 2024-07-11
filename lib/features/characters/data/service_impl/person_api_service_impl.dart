import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/repository/person_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@Named("PersonService")
@LazySingleton(as: RickAndMortyApiService<PersonEntity>)
class PersonApiServiceImpl implements RickAndMortyApiService<PersonEntity> {

  late int pageNumber;
  final PersonRepository repository;

  PersonApiServiceImpl({required this.repository});

  final _personsList = BehaviorSubject<List<PersonEntity>>();

  @override
  Stream<List<PersonEntity>> get getterEntitiesStream => _personsList.stream; 
  @override
 List<PersonEntity> get getterEntitiesList => _personsList.valueOrNull ?? [];

  @PostConstruct()
  void init() async{
    final newPage = await repository.getLastPage(); 
    pageNumber = newPage == 0 ? 1 : newPage;
    final persons =  await fetchAndCacheEntityByPage(pageNumber);
    _personsList.add(persons);
  }

  @override
  void updateData()async{
     final newPersons = await fetchAndCacheEntityByPage(pageNumber);
    final currentPersons = _personsList.valueOrNull ?? [];
    _personsList.add(currentPersons + newPersons);
  }

  @override
  Future<List<PersonEntity>> fetchAndCacheEntityByPage(int page) async {
    pageNumber++;
    return await repository.fetchCharactersByPage(page);
  }

  @override
  Future<List<PersonEntity>> fetchEntityByUrls(List<String> listUrl) async {
    return [];
  }
  

  @override
  Future<List<String>> getSearchHistory() async {
   return await repository.getSearchHistory();
  }
  
  @override
  Future<List<PersonEntity>> search(String query)async {
    return await repository.fetchDataByFilter(PersonFilter.name, query);
  }
 
}

