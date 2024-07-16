import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/search_history.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search Person');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        tooltip: 'Back',
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(SearchPerson(query));

    return BlocBuilder<SearchBloc, SearchBlocState>(builder: (context, state) {
      if (state is SearchBlocStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchBlocStateEmpty) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        );
      } else if (state is SearchBlocStateLoaded) {
        final personList = state.persons;
        return ListView.builder(
          itemCount: personList.isNotEmpty ? personList.length : 0,
          itemBuilder: (context, int index) {
            PersonEntity person = personList[index];
            return SearchResult(
              person: person,
              key: Key(person.id.toString()),
            );
          },
        );
      }
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchBlocState>(builder: (context, state) {
      if (state.searchHistory.isEmpty) {
        return Container(
          decoration: const BoxDecoration(color: Colors.black),
        );
      } else {
        return ListView.builder(
            itemCount: state.searchHistory.length,
            itemBuilder: (context, int index) {
              return SearchHistoryItem(
                textQuery: state.searchHistory[index],
                callback: (text) {
                  query = text;
                  showResults(context);
                },
              );
            });
      }
    });
  }
}
