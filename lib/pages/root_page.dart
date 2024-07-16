import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/pages/person_page.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/widgets/custom_search.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/presentation/pages/episode_page.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/presentation/pages/location_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    PersonPage(),
    LocationPage(),
    EpisodePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SearchBloc createBloc() {
    final service = inject<RickAndMortyApiService<PersonEntity>>(
        instanceName: "PersonService");
    return SearchBloc(service: service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(bloc: createBloc()));
              },
              icon: Icon(Icons.search)),
        ],
        title: const Text('Rick and Morty'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Persons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Episodes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _selectedIndex = 0;

//   static const List<Widget> _pages = <Widget>[
//     PersonPage(),
//     LocationPage(),
//     EpisodePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showSearch(context: context, delegate: CustomSearchDelegate());
//               },
//               icon: Icon(Icons.search)),
//         ],
//         title: const Text('Rick and Morty'),
//         ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Persons',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             label: 'Locations',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.tv),
//             label: 'Episodes',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
