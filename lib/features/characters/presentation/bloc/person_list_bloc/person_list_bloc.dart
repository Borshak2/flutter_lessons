import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';

class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
  PersonListBloc({
    required this.service,
  }) : super(
          PersonListState(personsList: service.getterEntitiesList, dataState: DataState.loaded),
        ) {
    _sub = service.getterEntitiesStream.listen((events) =>
        emit(state.copyWith(personsList: events, dataState: DataState.loaded)));
    _registerHandlers();
  }

  final RickAndMortyApiService<PersonEntity> service;
  late StreamSubscription<List<PersonEntity>> _sub;

  void _registerHandlers() {
    on<FetchPersonList>((_, emit) async {
      service.updateData();
    });
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}


// class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
//   PersonListBloc({
//     required this.service,
//     List<PersonEntity>? oldList,
//   }) : super(
//           oldList == null && oldList!.isNotEmpty
//               ? PersonListState(personsList: [], dataState: DataState.empty)
//               : PersonListState(
//                   personsList: oldList, dataState: DataState.loaded),
//         ) {
//     _sub = service.getterEntitiesStream.listen((events) =>
//         emit(state.copyWith(personsList: events, dataState: DataState.loaded)));
//     _registerHandlers();
//   }

//   final RickAndMortyApiService<PersonEntity> service;
//   late StreamSubscription<List<PersonEntity>> _sub;

//   void _registerHandlers() {
//     on<FetchPersonList>((_, emit) async {
//       service.updateData();
//     });
//   }

//   @override
//   Future<void> close() {
//     _sub.cancel();
//     return super.close();
//   }
// }