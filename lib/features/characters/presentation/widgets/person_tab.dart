
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_list_bloc/person_list_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/list_persons.dart';

class PersonsTab extends StatelessWidget {
  const PersonsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocProvider(
      create: (_) {
        final service = inject<RickAndMortyApiService<PersonEntity>>(instanceName: "PersonService");
        final initalData = service.getterEntitiesList;
        return PersonListBloc(service: service, oldList: initalData);},
        child: ListPersonWidget(),
        );

  }
}

