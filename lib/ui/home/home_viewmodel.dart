import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../core/models/todo_item.dart';
import '../../core/services/storage_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final navigationService = locator<NavigationService>();
  final formattedDate = DateFormat('EEEE d MMM yyyy').format(DateTime.now());

  final _descriptionController = TextEditingController();
  final _storageService = StorageService();

  get items => _storageService.getFromBox('items');

  void initialise() {
    notifyListeners();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void addItem({required String description}) {
    DateTime now = DateTime.now();
    int epochSeconds = now.millisecondsSinceEpoch ~/ 1000;
    final item = TodoItem(timeStamp: epochSeconds, description: description);
    _storageService.addToBox('items', item);
    notifyListeners();
  }

  void updateItem({required String description, required int index}) {
    DateTime now = DateTime.now();
    int epochSeconds = now.millisecondsSinceEpoch ~/ 1000;
    final item = TodoItem(timeStamp: epochSeconds, description: description);
    _storageService.updateInBox('items', index, item);
    notifyListeners();
  }

  void deleteContract({required int index}) {
    _storageService.deleteFromBox('items', index);
    notifyListeners();
  }

  void toggleIsCompleted({required int index, required bool value}) {
    final item = items[index];
    item.isComplete = value;
    _storageService.updateInBox('items', index, item);
    notifyListeners();
  }
}
