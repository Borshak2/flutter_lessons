import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final RickAndMortyApiService<PersonEntity> personService;
  final RickAndMortyApiService<LocationEntity> locationService;
    final RickAndMortyApiService<EpisodeEntity> episodeService;
  final Set<String> historyQueries = {};

  SearchBloc({required this.personService, required this.episodeService,required this.locationService}) : super(SearchBlocStateEmpty([])) {
    on<SearchPerson>(_onEvent);
    on<DeleteQueryInHistoy>(_deleteQueryInHistoy);
    on<InitialData>(_intitalData);
  }

  void _onEvent(SearchPerson event, emit) async {
    emit(SearchBlocStateLoading(historyQueries.toList()));
    try {
      final persons = await personService.searchEntity(event.query);
      final locations = await locationService.searchEntity(event.query);
      final episodes = await episodeService.searchEntity(event.query);
      emit(SearchBlocStateLoaded(historyQueries.toList(), persons: persons, locations: locations, episodes: episodes));
      historyQueries.add(event.query);
    } catch (_) {
      emit(SearchBlocStateEmpty(historyQueries.toList()));
    }
  }

  void _deleteQueryInHistoy(DeleteQueryInHistoy event, emit) {
    final bool deleted = historyQueries.remove(event.query);
    if (deleted) {
      emit(SearchBlocStateEmpty(historyQueries.toList()));
    }
  }

  void _intitalData(event, emit) async {
    final List<String> queriesList = await personService.getSearchHistory();
    if (queriesList.isNotEmpty) {
      historyQueries.addAll(queriesList.toSet());
      emit(SearchBlocStateEmpty(queriesList));
    } else {
      emit(SearchBlocStateEmpty([]));
    }
  }
}
