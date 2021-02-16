import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/i_number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final INumberTriviaRepository repository;
  const GetConcreteNumberTrivia({@required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  const Params({@required this.number});
  @override
  List<Object> get props => [number];
}
