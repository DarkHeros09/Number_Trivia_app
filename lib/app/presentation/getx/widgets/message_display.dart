import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
