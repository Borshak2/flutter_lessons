// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DashboardPage(key: args.key),
      );
    },
    EpisodeRoute.name: (routeData) {
      final args = routeData.argsAs<EpisodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EpisodePage(
          key: args.key,
          appBar: args.appBar,
        ),
      );
    },
    LocationRoute.name: (routeData) {
      final args = routeData.argsAs<LocationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LocationPage(
          key: args.key,
          appBar: args.appBar,
        ),
      );
    },
    PersonRoute.name: (routeData) {
      final args = routeData.argsAs<PersonRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PersonPage(
          key: args.key,
          appBar: args.appBar,
        ),
      );
    },
  };
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<DashboardRouteArgs> page =
      PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [EpisodePage]
class EpisodeRoute extends PageRouteInfo<EpisodeRouteArgs> {
  EpisodeRoute({
    Key? key,
    required CustomSearchDelegate appBar,
    List<PageRouteInfo>? children,
  }) : super(
          EpisodeRoute.name,
          args: EpisodeRouteArgs(
            key: key,
            appBar: appBar,
          ),
          initialChildren: children,
        );

  static const String name = 'EpisodeRoute';

  static const PageInfo<EpisodeRouteArgs> page =
      PageInfo<EpisodeRouteArgs>(name);
}

class EpisodeRouteArgs {
  const EpisodeRouteArgs({
    this.key,
    required this.appBar,
  });

  final Key? key;

  final CustomSearchDelegate appBar;

  @override
  String toString() {
    return 'EpisodeRouteArgs{key: $key, appBar: $appBar}';
  }
}

/// generated route for
/// [LocationPage]
class LocationRoute extends PageRouteInfo<LocationRouteArgs> {
  LocationRoute({
    Key? key,
    required CustomSearchDelegate appBar,
    List<PageRouteInfo>? children,
  }) : super(
          LocationRoute.name,
          args: LocationRouteArgs(
            key: key,
            appBar: appBar,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationRoute';

  static const PageInfo<LocationRouteArgs> page =
      PageInfo<LocationRouteArgs>(name);
}

class LocationRouteArgs {
  const LocationRouteArgs({
    this.key,
    required this.appBar,
  });

  final Key? key;

  final CustomSearchDelegate appBar;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, appBar: $appBar}';
  }
}

/// generated route for
/// [PersonPage]
class PersonRoute extends PageRouteInfo<PersonRouteArgs> {
  PersonRoute({
    Key? key,
    required CustomSearchDelegate appBar,
    List<PageRouteInfo>? children,
  }) : super(
          PersonRoute.name,
          args: PersonRouteArgs(
            key: key,
            appBar: appBar,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonRoute';

  static const PageInfo<PersonRouteArgs> page = PageInfo<PersonRouteArgs>(name);
}

class PersonRouteArgs {
  const PersonRouteArgs({
    this.key,
    required this.appBar,
  });

  final Key? key;

  final CustomSearchDelegate appBar;

  @override
  String toString() {
    return 'PersonRouteArgs{key: $key, appBar: $appBar}';
  }
}
