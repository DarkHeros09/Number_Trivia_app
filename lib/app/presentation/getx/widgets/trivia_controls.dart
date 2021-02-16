import 'package:flutter/material.dart';

import '../home_get_controller.dart';

class TriviaControls extends StatelessWidget {
  final HomeGetController controller;
  const TriviaControls({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller.txtcontroller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            controller.inputString = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: const Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: const Text('Get random trivia'),
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.txtcontroller.clear();
    controller.getConcreteTrivia(controller.inputString);
  }

  void dispatchRandom() {
    controller.txtcontroller.clear();
    controller.getRandomTrivia();
  }
}
