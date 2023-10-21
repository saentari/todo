import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/common/widgets/bottom_sheet_widget.dart';
import 'package:todo/core/models/todo_item.dart';
import 'package:todo/core/services/storage_service.dart';

class TodoViewModel extends ReactiveViewModel {
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

  void openItem(int? index) {
    if (index != null) {
      _descriptionController.text = items[index].description;
    } else {
      _descriptionController.clear();
    }

    BottomSheetWidget.showBottomSheet(
      content: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(border: InputBorder.none),
              autofocus: true,
              maxLines: 2,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  if (_descriptionController.text.isNotEmpty) {
                    if (index != null) {
                      updateItem(index: index, description: _descriptionController.text);
                    } else {
                      addItem(description: _descriptionController.text);
                    }
                    Get.back();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
