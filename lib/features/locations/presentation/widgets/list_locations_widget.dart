import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_state.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/loactions_list_event.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/locations_list_state.dart';

class ListLocationsWidget extends StatefulWidget {
  ListLocationsWidget({Key? key}) : super(key: key);

  @override
  State<ListLocationsWidget> createState() => _ListLocationsWidgetState();
}

class _ListLocationsWidgetState extends State<ListLocationsWidget> {
  final scrollController = ScrollController();

  void setupController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<LocationsListBloc>().add(LocationsListStateGetData());
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
    return BlocBuilder<LocationsListBloc, LocationsListState>(
      builder: (context, state) {
        if (state.dataState == DataState.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.separated(
                key: const PageStorageKey<String>('ListLocationWidget'),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(state.locationsList[index].name),
                    subtitle: Text(state.locationsList[index].type),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: state.locationsList.length,
              ),
            ],
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
