import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/widgets/custom_search.dart';
import 'package:flutter_lesson_3_rick_v2/router/app_router.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  final CustomSearchDelegate searchDelegate;

  DashboardPage({super.key})
      : searchDelegate = CustomSearchDelegate(
          key: UniqueKey(),
          bloc: SearchBloc(
            personService: inject<RickAndMortyApiService<PersonEntity>>(
                instanceName: "PersonService"),
            episodeService: inject<RickAndMortyApiService<EpisodeEntity>>(
                instanceName: "EpisodeService"),
            locationService: inject<RickAndMortyApiService<LocationEntity>>(
                instanceName: "LocationService"),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        PersonRoute(appBar: searchDelegate),
        LocationRoute(appBar: searchDelegate),
        EpisodeRoute(appBar: searchDelegate),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'person',
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                label: 'location',
                icon: Icon(Icons.location_on),
              ),
              BottomNavigationBarItem(
                label: 'episode',
                icon: Icon(Icons.tv),
              ),
            ],
          ),
        );
      },
    );
  }
}
