import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/core/services/storage_service.dart';
import 'package:todo/ui/home/home_view.dart';
import 'package:todo/ui/todo/todo_view.dart';

@StackedApp(
  routes: [
    CustomRoute(page: TodoView, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: HomeView, transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
  dependencies: [
    LazySingleton(classType: StorageService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
)
class App {}
