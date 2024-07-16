import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/perosn_card.dart';

class ListPersonWidget extends StatefulWidget {
  ListPersonWidget({Key? key}) : super(key: key);

  @override
  State<ListPersonWidget> createState() => _ListPersonWidgetState();
}

class _ListPersonWidgetState extends State<ListPersonWidget> {
  final scrollController = ScrollController();

  void setupController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListBloc>().add(FetchPersonList());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupController(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListBloc, PersonListState>(
      builder: (context, state) {
        if (state.dataState == DataState.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            key: const PageStorageKey<String>('ListPersonWidget'),
            controller: scrollController,
            itemBuilder: (context, index) {
              // return ListTile(
              //   title: Text(state.personsList[index].name),
              //   subtitle: Text(state.personsList[index].status),
              // );
              return PersonCard(person: state.personsList[index]);
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.personsList.length,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
