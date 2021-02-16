import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
