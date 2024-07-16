import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/bloc/epsiode_list_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/widgets/list_episode_widget.dart';

class EpisodePage extends StatelessWidget {
  const EpisodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final service = inject<RickAndMortyApiService<EpisodeEntity>>(
            instanceName: "EpisodeService");
        return EpisodeListBloc(service: service);
      },
      child: ListEpisodesWidget(),
    );
  }
}