import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/app/app.router.dart';
import 'package:todo/ui/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'todo',
                        style: TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.formattedDate,
                        style: const TextStyle(color: Color(0xFF949393)),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  color: const Color(0xFFE8E8E8),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'What do you want to do today?',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Start adding items to your to-do list.',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => viewModel.navigationService.navigateToTodoView(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      minimumSize: const Size(200, 60)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        'Add item',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialise();
}
