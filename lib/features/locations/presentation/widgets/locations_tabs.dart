import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/bloc/bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/widgets/list_locations_widget.dart';

class LocationsTab extends StatelessWidget {
  const LocationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final service = inject<RickAndMortyApiService<LocationEntity>>(
            instanceName: "LocationService");
        final initalData = service.getterEntitiesList;
        return LocationsListBloc(service: service, oldList: initalData);
      },
      child: ListLocationsWidget(),
    );
  }
}
