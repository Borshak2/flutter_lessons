import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/custom_search.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/person_tab.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/widgets/episode_tab.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/widgets/locations_tabs.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search)),
        ],
        title: const Text('Rick and Morty'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Persons'),
            Tab(text: 'Locations'),
            Tab(text: 'Episodes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PersonsTab(),
          LocationsTab(),
          EpisodesTab(),
        ],
      ),
    );
  }
}
