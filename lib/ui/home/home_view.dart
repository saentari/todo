import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/common/widgets/bottom_sheet_widget.dart';

import '../../common/widgets/dashed_divider.dart';
import '../../core/models/todo_item.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('todo', style: TextStyle(fontSize: 24)),
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1)),
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
          return const DashedDivider(indent: 70);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 1,
        onPressed: () => BottomSheetWidget.showBottomSheet(
          content: BottomSheetData(
            addItemFunction: (description) => viewModel.addItem(description: description),
          ),
        ),
        shape: const CircleBorder(),
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

class BottomSheetData extends StatefulWidget {
  const BottomSheetData({super.key, required this.addItemFunction});

  final Function(String) addItemFunction;

  @override
  BottomSheetDataState createState() => BottomSheetDataState();
}

class BottomSheetDataState extends State<BottomSheetData> {
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
            decoration: InputDecoration(
              hintText: 'Description',
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Color(0xFFBE5151)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Color(0xFFBE5151)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'No description found';
              }
              return null;
            },
            onChanged: (value) => setState(() => name = value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    widget.addItemFunction(name);
                    Navigator.pop(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
