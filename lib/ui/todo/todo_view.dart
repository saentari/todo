import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/core/models/todo_item.dart';
import 'package:todo/ui/todo/todo_viewmodel.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, TodoViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo', style: TextStyle(fontSize: 32)),
        automaticallyImplyLeading: false,
        elevation: 1,
        scrolledUnderElevation: 1,
        toolbarHeight: 80,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: viewModel.items.length,
        itemBuilder: (context, index) {
          TodoItem item = viewModel.items[index];
          return CheckboxListTile(
            title: Text(
              item.description,
              style: TextStyle(
                  fontSize: 16, decoration: item.isComplete ? TextDecoration.lineThrough : TextDecoration.none),
            ),
            onChanged: (bool? value) => viewModel.toggleIsCompleted(index: index, value: !item.isComplete),
            value: item.isComplete,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.black,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 56,
            color: Color(0xFFD7D7D7),
            thickness: 1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 1,
        onPressed: () => viewModel.openItem(null),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.initialise();
}
