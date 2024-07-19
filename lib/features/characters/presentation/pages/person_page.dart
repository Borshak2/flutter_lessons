import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/list_persons.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/widgets/custom_search.dart';

@RoutePage()
class PersonPage extends StatelessWidget {
  final CustomSearchDelegate appBar;
  const PersonPage({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: appBar);
              },
              icon: Icon(Icons.search)),
        ],
        title: const Text('Rick and Morty'),
      ),
      body: BlocProvider(
        create: (_) {
          final service = inject<RickAndMortyApiService<PersonEntity>>(
              instanceName: "PersonService");
          return PersonListBloc(service: service);
        },
        child: ListPersonWidget(),
      ),
    );
  }
}
