import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/loactions_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/locations_list_state.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  LocationsListBloc({
    required this.service,
  }) : super(
          LocationsListState(
            locationsList: service.getterEntitiesList, 
            dataState: service.getterEntitiesList.isEmpty ? DataState.empty : DataState.loaded,
          ),
        ) {
    _sub = service.getterEntitiesStream.listen((events) => emit(
        state.copyWith(locationsList: events, dataState: DataState.loaded)));
    _registerHandlers();
  }

  final RickAndMortyApiService<LocationEntity> service;
  late StreamSubscription<List<LocationEntity>> _sub;

  void _registerHandlers() {
    on<LocationsListStateGetData>((_, emit) async {
      service.updateData();
    });
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}