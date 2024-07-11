import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';



class LocationsListState {
  final List<LocationEntity> locationsList;
  final DataState dataState;

  LocationsListState({
    required this.locationsList,
    required this.dataState,
  });

  LocationsListState copyWith({
    List<LocationEntity>? locationsList,
    DataState? dataState,
  }) {
    return LocationsListState(
      locationsList: locationsList != null && locationsList.isNotEmpty 
          ? this.locationsList + locationsList 
          : this.locationsList,
      dataState: dataState ?? this.dataState,
    );
  }
}
