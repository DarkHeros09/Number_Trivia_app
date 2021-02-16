import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/loading_widget.dart';
import 'home_get_controller.dart';
import 'widgets/widgets.dart';

///Number Trivia Home View
class HomeGet extends GetView<HomeGetController> {
  ///const Constructor
  const HomeGet();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia App'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  // Top half
                  Obx(() {
                    switch (controller.viewState.value) {
                      case ViewState.empty:
                        return const MessageDisplay(
                            message: 'Start Searching!');
                        break;
                      case ViewState.loading:
                        return const LoadingWidget();
                        break;
                      case ViewState.loaded:
                        return TriviaDisplay(numberTrivia: controller.trivia);
                        break;
                      case ViewState.error:
                        return MessageDisplay(message: controller.errorMessage);
                        break;
                      default:
                        return const LoadingWidget();
                    }
                  }),

                  const SizedBox(height: 20),
                  // Bottom half
                  TriviaControls(
                    controller: controller,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
