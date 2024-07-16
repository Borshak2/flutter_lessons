import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

sealed class SearchBlocState {
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
  final List<LocationEntity> locations;
  final List<EpisodeEntity> episodes;

  SearchBlocStateLoaded(super.searchHistory,{required this.persons, required this.locations,required this.episodes} );
}
