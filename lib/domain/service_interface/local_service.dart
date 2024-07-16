abstract class LocalDataService<T> {
  Future<List<T>> getLastDtosFromCache();
  Future<int> getLastPage();
  Future<void> addDtosToCache(List<T> newDtos, int page);
  Future<List<String>> getCachedQueries();
  Future<void> cacheQuery(String query);
}
