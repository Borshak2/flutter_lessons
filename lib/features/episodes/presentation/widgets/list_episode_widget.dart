import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/episode_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/epsiode_list_bloc.dart';


class ListEpisodesWidget extends StatefulWidget {
  ListEpisodesWidget({Key? key}) : super(key: key);

  @override
  State<ListEpisodesWidget> createState() => _ListEpisodesWidgetState();
}

class _ListEpisodesWidgetState extends State<ListEpisodesWidget> {
  final scrollController = ScrollController();

  void setupController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<EpsiodeListBloc>().add(EpisodeListStateGetData());
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
    return BlocBuilder<EpsiodeListBloc, EpisodeListState>(
      builder: (context, state) {
        if (state.dataState == DataState.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            key: const PageStorageKey<String>('ListEpisodeWidget'),
            controller: scrollController,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.episodesList[index].name),
                subtitle: Text(state.episodesList[index].episode),
              );
              // return PersonCard(person: state.personsList[index]);
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.episodesList.length,
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