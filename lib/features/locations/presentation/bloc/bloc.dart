import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/loactions_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/locations_list_state.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  LocationsListBloc({
    required this.service,
    List<LocationEntity>? oldList,
  }) : super(
     oldList == null && oldList!.isNotEmpty ?
    LocationsListState(locationsList: [], dataState: DataState.empty) : LocationsListState(locationsList: oldList, dataState: DataState.loaded),
  ){
    // ignore: invalid_use_of_visible_for_testing_member
    service.getterEntitiesStream.listen((events) => emit(state.copyWith(locationsList: events,dataState: DataState.loaded)));
    _registerHandlers();
  }

  final RickAndMortyApiService<LocationEntity> service;
 
  void _registerHandlers() {
    on<LocationsListStateGetData>(
      (_, emit) async {
        service.updateData();
      }
    );
  }
}