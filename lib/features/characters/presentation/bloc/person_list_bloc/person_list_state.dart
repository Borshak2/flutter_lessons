import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

enum DataState { empty, loading, loaded, error }

class PersonListState {
  final List<PersonEntity> personsList;
  final DataState dataState;

  PersonListState({
    required this.personsList,
    required this.dataState,
  });

  PersonListState copyWith({
    List<PersonEntity>? personsList,
    DataState? dataState,
  }) {
    return PersonListState(
      personsList: personsList != null && personsList.isNotEmpty
          ? this.personsList + personsList
          : this.personsList,
      dataState: dataState ?? this.dataState,
    );
  }
}
