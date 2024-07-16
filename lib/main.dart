import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/common/app_colors.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/domain/service_interface/api_service.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/presentation/bloc/person_search_bloc/search_bloc.dart';
import 'package:flutter_lesson_3_rick_v2/pages/root_page.dart';

import 'domain/entities/person_entitiy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        // home: const PersonPageOld(),
        home: const RootPage(),
      );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) {
//         final service = inject<RickAndMortyApiService<PersonEntity>>(
//             instanceName: "PersonService");
//         return SearchBloc(service: service);
//       },
//       child: MaterialApp(
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: AppColors.mainBackground,
//         ),
//         // home: const PersonPageOld(),
//         home: const RootPage(),
//       ),
//     );
//   }
// }
