import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

abstract class SearchBlocState {
  final List<String> searchHistory;
  SearchBlocState(this.searchHistory);
}

class SearchBlocStateEmpty extends SearchBlocState {
  SearchBlocStateEmpty(super.searchHistory);
}

class SearchBlocStateLoading extends SearchBlocState {
  SearchBlocStateLoading(super.searchHistory);
}

class SearchBlocStateLoaded extends SearchBlocState {
  final List<PersonEntity> persons;

  SearchBlocStateLoaded(this.persons, super.searchHistory);
}
