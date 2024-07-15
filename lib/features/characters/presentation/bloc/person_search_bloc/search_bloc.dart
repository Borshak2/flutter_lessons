import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final RickAndMortyApiService<PersonEntity> service;
  final Set<String> historyQueries = {};

  SearchBloc({required this.service}) : super(SearchBlocStateEmpty([])) {
    on<SearchPerson>(_onEvent);
    on<DeleteQueryInHistoy>(_deleteQueryInHistoy);
    on<InitialData>(_intitalData);
  }

  void _onEvent(SearchPerson event, emit) async {
    emit(SearchBlocStateLoading(historyQueries.toList()));
    try {
      final resault = await service.searchEntity(event.query);
      emit(SearchBlocStateLoaded(resault,historyQueries.toList()));
      historyQueries.add(event.query);
    } catch (_) {
      emit(SearchBlocStateEmpty(historyQueries.toList()));
    }
  }

  void _deleteQueryInHistoy(DeleteQueryInHistoy event,emit){
    final bool deleted = historyQueries.remove(event.query);
    if(deleted){
      emit(SearchBlocStateEmpty(historyQueries.toList()));
    }
  }

  void _intitalData(event,emit) async {
    final List<String> queriesList = await service.getSearchHistory();
    if (queriesList.isNotEmpty) {
      historyQueries.addAll(queriesList.toSet());
      emit(SearchBlocStateEmpty(queriesList));
    } else{
      emit(SearchBlocStateEmpty([]));
    }
  }
}
