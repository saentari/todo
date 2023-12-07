import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/bottom_sheet_widget.dart';
import '../../common/widgets/dashed_divider.dart';
import '../../core/models/todo_item.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.titleText, style: const TextStyle(fontSize: 24)),
        automaticallyImplyLeading: false,
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
                fontSize: 16,
                decoration: item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            onChanged: (value) => BottomSheetWidget.showBottomSheet(
              content: BottomSheetDataEdit(
                item: item,
                toggleItemFunction: () => viewModel.toggleIsCompleted(index: index, value: !item.isComplete),
                editItemFunction: (description) => viewModel.updateItem(description: description, index: index),
                deleteItemFunction: () => viewModel.deleteItem(index: index),
              ),
            ),
            value: item.isComplete,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.black,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const DashedDivider(indent: 70);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BottomSheetWidget.showBottomSheet(
            content: BottomSheetDataAdd(
          addItemFunction: (description) => viewModel.addItem(description: description),
        )),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialise();
}

class BottomSheetDataAdd extends StatefulWidget {
  const BottomSheetDataAdd({super.key, required this.addItemFunction});

  final Function(String) addItemFunction;

  @override
  BottomSheetDataAddState createState() => BottomSheetDataAddState();
}

class BottomSheetDataAddState extends State<BottomSheetDataAdd> {
  final _formKey = GlobalKey<FormState>();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'No description was found';
              }
              return null;
            },
            onChanged: (value) => name = value,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.addItemFunction(name);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetDataEdit extends StatefulWidget {
  const BottomSheetDataEdit({
    super.key,
    required this.item,
    required this.toggleItemFunction,
    required this.editItemFunction,
    required this.deleteItemFunction,
  });

  final TodoItem item;
  final Function() toggleItemFunction;
  final Function(String) editItemFunction;
  final Function() deleteItemFunction;

  @override
  BottomSheetDataEditState createState() => BottomSheetDataEditState();
}

class BottomSheetDataEditState extends State<BottomSheetDataEdit> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  TodoItem? _todoItem;
  String _mainButtonText = '';
  String _newDescription = '';
  bool _isChanged = false;
  String _secondaryButtonText = 'Give up';

  @override
  void initState() {
    _todoItem = widget.item;
    _controller.text = _todoItem!.description;
    if (_todoItem?.isComplete == false) {
      _mainButtonText = 'Complete';
    } else {
      _mainButtonText = 'Open';
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'No description was found';
              }
              return null;
            },
            onChanged: (value) {
              if (value != _todoItem?.description) {
                setState(() {
                  _isChanged = true;
                  _newDescription = value;
                  _mainButtonText = 'Save';
                  _secondaryButtonText = 'Cancel';
                });
              } else {
                setState(() {
                  _isChanged = false;
                  _newDescription = value;
                  _mainButtonText =
                      _todoItem?.isComplete == false ? _mainButtonText = 'Complete' : _mainButtonText = 'Open';
                  _secondaryButtonText = 'Give up';
                });
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    if (_isChanged) {
                      _controller.text = widget.item.description;
                    } else {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Giving up?',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Text(
                                    'This will delete the item.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          style: TextButtonTheme.of(context).style?.copyWith(
                                                backgroundColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF)),
                                                foregroundColor: const MaterialStatePropertyAll(Color(0xFF000000)),
                                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                  side: const BorderSide(color: Color(0xFFD7D7D7)),
                                                  borderRadius: BorderRadius.circular(10.0),
                                                )),
                                              ),
                                          child: const Text('Never'),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            widget.deleteItemFunction();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: TextButtonTheme.of(context).style?.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF)),
                        foregroundColor: const MaterialStatePropertyAll(Color(0xFF000000)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFD7D7D7)),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                      ),
                  child: Text(_secondaryButtonText),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    if (_isChanged) {
                      widget.editItemFunction(_newDescription);
                    } else {
                      widget.toggleItemFunction();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(_mainButtonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
