import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';



class EpisodeListState {
  final List<EpisodeEntity> episodesList;
  final DataState dataState;

  EpisodeListState({
    required this.episodesList,
    required this.dataState,
  });

  EpisodeListState copyWith({
    List<EpisodeEntity>? episodesList,
    DataState? dataState,
  }) {
    return EpisodeListState(
      episodesList: episodesList != null && episodesList.isNotEmpty 
          ? this.episodesList + episodesList 
          : this.episodesList,
      dataState: dataState ?? this.dataState,
    );
  }
}
