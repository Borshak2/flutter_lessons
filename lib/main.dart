import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_rick_v2/common/app_colors.dart';
import 'package:flutter_lesson_3_rick_v2/di/locator_service.dart';
import 'package:flutter_lesson_3_rick_v2/router/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = inject<AppRouter>();
    return  MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
      );
  }
}
