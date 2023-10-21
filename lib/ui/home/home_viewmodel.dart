import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';

class HomeViewModel extends ReactiveViewModel {
  final navigationService = locator<NavigationService>();
  final formattedDate = DateFormat('EEEE d MMM yyyy').format(DateTime.now());

  void initialise() {
    notifyListeners();
  }
}
