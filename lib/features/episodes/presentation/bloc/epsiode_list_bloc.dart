import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_state.dart';

class EpisodeListBloc extends Bloc<EpisodeListEvent, EpisodeListState> {
  EpisodeListBloc({
    required this.service,
  }) : super(
          EpisodeListState(
            episodesList: service.getterEntitiesList, 
            dataState: service.getterEntitiesList.isEmpty ? DataState.empty : DataState.loaded,
          ),
        ) {
    _sub = service.getterEntitiesStream.listen((events) => emit(
        state.copyWith(episodesList: events, dataState: DataState.loaded)));
    _registerHandlers();
  }

  final RickAndMortyApiService<EpisodeEntity> service;
  late StreamSubscription<List<EpisodeEntity>> _sub;

  void _registerHandlers() {
    on<EpisodeListStateGetData>((_, emit) async {
      service.updateData();
    });
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
