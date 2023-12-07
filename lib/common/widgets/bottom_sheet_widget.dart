import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    this.widget = const SizedBox(),
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(0),
      width: double.maxFinite,
      child: Wrap(
        children: [widget],
      ),
    );
  }

  static void showBottomSheet({required Widget content}) {
    Get.bottomSheet(
      backgroundColor: const Color(0xFFF8F8F8),
      elevation: 0,
      isScrollControlled: true,
      BottomSheetWidget(widget: content),
    );
  }
}
