import 'dart:ui';

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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(0),
          width: double.maxFinite,
          child: Wrap(
            children: [widget],
          ),
        )
      ],
    );
  }

  static void showBottomSheet({required Widget content}) {
    Get.bottomSheet(
      elevation: 0,
      isScrollControlled: true,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: BottomSheetWidget(widget: content),
      ),
    );
  }
}
