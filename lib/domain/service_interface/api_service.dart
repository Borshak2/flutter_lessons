abstract class RickAndMortyApiService<T>{
  Future<List<T>> fetchAndCacheEntityByPage(int page);
  Future<List<T>> fetchEntityByUrls(List<String> listUrl);
  void updateData();
  Stream<List<T>> get getterEntitiesStream;
  List<T> get getterEntitiesList;
  Future<List<String>> getSearchHistory();
  Future<List<T>> searchEntity(String query);
}