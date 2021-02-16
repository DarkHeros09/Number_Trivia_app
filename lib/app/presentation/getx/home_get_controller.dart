import 'package:Clean_Code_NumberTrivia/di/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

// to simulate the cubit effect, and control the view
enum ViewState { empty, loading, loaded, error }

class HomeGetController extends GetxController {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  HomeGetController({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  var viewState = ViewState.empty.obs;

  String inputString;
  final txtcontroller = TextEditingController();

  NumberTrivia _trivia;
  NumberTrivia get trivia => _trivia;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  @override
  void onClose() {
    viewState.close();
    // to close open containers when finished.
    Injector.container.clear();
    super.onClose();
  }

  void getConcreteTrivia(String numberString) {
    final inputEither = inputConverter.stringToUnsignedInteger(numberString);
    inputEither.fold<dynamic>(
      (failure) {
        _errorMessage = failure.message;
        viewState.value = ViewState.error;
        Left<Failure, dynamic>(failure);
      },
      (trivia) async {
        viewState.value = ViewState.loading;
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: trivia));
        failureOrTrivia.fold<Either<Failure, NumberTrivia>>(
          (failure) {
            _errorMessage = failure.message;
            debugPrint(_errorMessage);
            viewState.value = ViewState.error;
            return Left(failure);
          },
          (data) {
            _trivia = data;
            debugPrint(_trivia.text);
            viewState.value = ViewState.loaded;
            return Right(data);
          },
        );
        // viewState.value = ViewState.loaded;
      },
    );
  }

  void getRandomTrivia() async {
    viewState.value = ViewState.loading;
    final failureOrTrivia = await getRandomNumberTrivia(const NoParams());
    failureOrTrivia.fold<Either<Failure, NumberTrivia>>(
      (failure) {
        viewState.value = ViewState.error;
        _errorMessage = failure.message;
        return Left(failure);
      },
      (data) {
        viewState.value = ViewState.loaded;
        return Right(_trivia = data);
      },
    );
  }
}
