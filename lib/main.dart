import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/common/constants/theme.dart';
import 'package:todo/core/models/todo_item.dart';

Future<void> main() async {
  // Hive Storage
  Hive.registerAdapter(TodoItemAdapter());

  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  // Stacked Services
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MobileApp()));
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
