abstract class SearchBlocEvent {}

class SearchPerson extends SearchBlocEvent {
  final String query;

  SearchPerson(this.query);
}

class InitialData extends SearchBlocEvent {}

class DeleteQueryInHistoy extends SearchBlocEvent {
  final String query;

  DeleteQueryInHistoy(this.query);
}
