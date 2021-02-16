import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/failure.dart';
import '../../models/number_trivia_model.dart';

abstract class INumberTriviaLocalDataSource {
  Future<Either<Failure, NumberTriviaModel>> getLastNumberTriviaModel();
  Future<void> cacheTrivia(NumberTriviaModel triviaCacheModel);
}

const NUMBER_TRIVIA_KEY = 'NUMBER_TRIVIA_KEY';
const CACHE_ERROR_MESSAGE = "There's No Trivia Saved 😢";

class NumberTriviaLocalDataSourceImpl implements INumberTriviaLocalDataSource {
  final SharedPreferences sharedPrefrences;
  const NumberTriviaLocalDataSourceImpl({
    @required this.sharedPrefrences,
  });

  @override
  Future<Either<Failure, NumberTriviaModel>> getLastNumberTriviaModel() {
    //returns a the stored value which is a json
    final jsonString = sharedPrefrences.getString(NUMBER_TRIVIA_KEY);
    if (jsonString != null && jsonString.isNotEmpty) {
      // we used Future.value because the method is Future
      return Future.value(
        Right(
          // cast jsonDecode(jsonString) as Map<String, dynamic> to avoid the argument type error.
          NumberTriviaModel.fromJson(
              jsonDecode(jsonString) as Map<String, dynamic>),
        ),
      );
    } else {
      return Future.value(
          const Left(CacheFailure(message: CACHE_ERROR_MESSAGE)));
    }
  }

  @override
  Future<void> cacheTrivia(NumberTriviaModel triviaCacheModel) {
    //stores the model into a json
    //setString returns a future, so we don't need to wrap the method in future
    return sharedPrefrences.setString(
        NUMBER_TRIVIA_KEY,
        jsonEncode(
          // Not sure the use of .toJson()
          triviaCacheModel.toJson(),
        ));
  }
}
