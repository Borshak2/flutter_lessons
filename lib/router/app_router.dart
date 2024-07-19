import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/pages/person_page.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/pages/episode_page.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/pages/location_page.dart';
import 'package:flutter_lesson_3_rick_v2/features/search/presentation/widgets/custom_search.dart';
import 'package:flutter_lesson_3_rick_v2/pages/root_page.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            initial: true,
            page: DashboardRoute.page,
            path: '/dashbord',
            children: [
              AutoRoute(page: PersonRoute.page, path: 'person'),
              AutoRoute(page: LocationRoute.page, path: 'location'),
              AutoRoute(page: EpisodeRoute.page, path: 'episode'),
            ]),
      ];
}
