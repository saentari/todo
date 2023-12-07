import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/storage_service.dart';
import '../../ui/home/home_view.dart';

@StackedApp(
  routes: [
    CustomRoute(page: HomeView, transitionsBuilder: TransitionsBuilders.noTransition),
  ],
  dependencies: [
    LazySingleton(classType: StorageService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
)
class App {}
