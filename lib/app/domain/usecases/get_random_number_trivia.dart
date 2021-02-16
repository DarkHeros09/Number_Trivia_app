import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/i_number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final INumberTriviaRepository repository;
  const GetRandomNumberTrivia({@required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) {
    return repository.getRandomNumberTrivia();
  }
}
