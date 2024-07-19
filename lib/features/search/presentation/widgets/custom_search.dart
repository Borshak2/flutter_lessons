import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/widgets/search_history.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc bloc;
  
  CustomSearchDelegate({required this.bloc, required UniqueKey key}) : super(searchFieldLabel: 'Search Person');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.add(SearchPerson(query));

    return BlocBuilder<SearchBloc, SearchBlocState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchBlocStateLoading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SearchBlocStateEmpty:
            return Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            );
          case SearchBlocStateLoaded:
            final stateLoaded = state as SearchBlocStateLoaded;

            // Build the list of search results by category
            List<Widget> results = [];

            // Persons
            if (stateLoaded.persons.isNotEmpty) {
              results.addAll([
                _buildCategoryHeader('Persons'),
                ...stateLoaded.persons.map((person) => PersonResult(person: person, key: Key('person_${person.id}'))),
              ]);
            }

            // Locations
            if (stateLoaded.locations.isNotEmpty) {
              results.addAll([
                _buildCategoryHeader('Locations'),
                ...stateLoaded.locations.map((location) => LocationResult(location: location, key: Key('location_${location.id}'))),
              ]);
            }

            // Episodes
            if (stateLoaded.episodes.isNotEmpty) {
              results.addAll([
                _buildCategoryHeader('Episodes'),
                ...stateLoaded.episodes.map((episode) => EpisodeResult(episode: episode, key: Key('episode_${episode.id}'))),
              ]);
            }

            return ListView(
              children: results,
            );
          default:
            return Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            );
        }
      },
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchBlocState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchBlocStateEmpty:
            return Container(
              decoration: const BoxDecoration(color: Colors.black),
            );
          default:
            final searchHistory = state.searchHistory;
            return ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, int index) {
                return SearchHistoryItem(
                  textQuery: searchHistory[index],
                  callback: (text) {
                    query = text;
                    showResults(context);
                  },
                );
              },
            );
        }
      },
    );
  }

    @override
  void showResults(BuildContext context) {
    bloc.add(SearchPerson(query));
    super.showResults(context);
  }

  @override
  void showSuggestions(BuildContext context) {
    bloc.add(SearchPerson(query));
    super.showSuggestions(context);
  }
}


