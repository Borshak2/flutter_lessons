import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_state.dart';

class EpsiodeListBloc extends Bloc<EpisodeListEvent, EpisodeListState> {
  EpsiodeListBloc({
    required this.service,
    List<EpisodeEntity>? oldList,
  }) : super(
     oldList == null && oldList!.isNotEmpty ?
    EpisodeListState(episodesList: [], dataState: DataState.empty) : EpisodeListState(episodesList: oldList, dataState: DataState.loaded),
  ){
    // ignore: invalid_use_of_visible_for_testing_member
    service.getterEntitiesStream.listen((events) => emit(state.copyWith(episodesList: events,dataState: DataState.loaded)));
    _registerHandlers();
  }

  final RickAndMortyApiService<EpisodeEntity> service;
 
  void _registerHandlers() {
    on<EpisodeListStateGetData>(
      (_, emit) async {
        service.updateData();
      }
    );
  }
}