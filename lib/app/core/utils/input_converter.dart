import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

const INVALID_INPUT = "Invalid input🚫\nPlease enter a number ‼";
const EMPTY_INPUT = "Empty input🚫\nPlease enter a number ‼";

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String numberString) {
    try {
      if (numberString == null || numberString.isEmpty) {
        return const Left(InvalidInputFailure(message: EMPTY_INPUT));
      } else {
        final integer = int.parse(numberString);
        if (integer < 0) throw const FormatException();
        return Right(integer);
      }
    } on FormatException {
      return const Left(InvalidInputFailure(message: INVALID_INPUT));
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  final String message;
  const InvalidInputFailure({this.message}) : super(message: message);
}
