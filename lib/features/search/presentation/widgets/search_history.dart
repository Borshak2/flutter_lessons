import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc_event.dart';

class SearchHistoryItem extends StatelessWidget {
  final String textQuery;
  final Function callback;
  const SearchHistoryItem(
      {super.key, required this.textQuery, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call(textQuery);
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(textQuery),
            IconButton(
                onPressed: () {
                  context
                      .read<SearchBloc>()
                      .add(DeleteQueryInHistoy(textQuery));
                },
                icon: const Icon(Icons.clear)),
          ],
        ),
      ),
    );
  }
}
