
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/repository/episode_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';



@Named("EpisodeService")
@LazySingleton(as: RickAndMortyApiService<EpisodeEntity>)
class EpisodesApiServiceImpl implements RickAndMortyApiService<EpisodeEntity> {

  late int pageNumber;
  final EpisodeRepository repository;

  EpisodesApiServiceImpl({required this.repository});

  final _episodesList = BehaviorSubject<List<EpisodeEntity>>();

  @override
  Stream<List<EpisodeEntity>> get getterEntitiesStream => _episodesList.stream; 
  @override
 List<EpisodeEntity> get getterEntitiesList => _episodesList.valueOrNull ?? [];

  @PostConstruct()
  void init() async{
    final newPage = await repository.getLastPage(); 
    pageNumber = newPage == 0 ? 1 : newPage;
    final episodes =  await fetchAndCacheEntityByPage(pageNumber);
    _episodesList.add(episodes);
  }

  @override
  void updateData()async{
     final newEpisodes = await fetchAndCacheEntityByPage(pageNumber);
    final currentEpisodes = _episodesList.valueOrNull ?? [];
    _episodesList.add(currentEpisodes + newEpisodes);
  }

  @override
  Future<List<EpisodeEntity>> fetchAndCacheEntityByPage(int page) async {
    pageNumber++;
    return await repository.fetchEpisodesByPage(page);
  }

  @override
  Future<List<EpisodeEntity>> fetchEntityByUrls(List<String> listUrl) async {
    return [];
  }
  
  @override
  Future<List<String>> getSearchHistory() async {
    return await repository.getQuerisList();
  }
  
  
  @override
  Future<List<EpisodeEntity>> searchEntity(String query) async{
    return repository.fetchDataByFilter(EpisodeFilter.name, query);
  }
  

}
