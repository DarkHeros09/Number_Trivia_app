import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/i_number_trivia_repository.dart';
import '../datasources/local/i_number_trivia_local_data_source.dart';
import '../datasources/remote/i_number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';

typedef _ConcreteOrRandomChoose = Future<Either<Failure, NumberTrivia>>
    Function();

class NumberTriviaRepositoryImpl implements INumberTriviaRepository {
  final INumberTriviaRemoteDataSource remoteDataSource;
  final INumberTriviaLocalDataSource localDataSource;
  final INetworkInfo networkInfo;
  const NumberTriviaRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
    @required this.localDataSource,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChoose concreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      final response = await concreteOrRandom();
      return response.fold(
        (failure) => Left(failure),
        (trivia) async {
          // cast trivia as NumberTriviaModel to avoid the argument type error.
          await localDataSource.cacheTrivia(trivia as NumberTriviaModel);
          debugPrint('cache is ${trivia.text}');
          return Right(trivia);
        },
      );
    } else {
      final response = await localDataSource.getLastNumberTriviaModel();
      return response.fold(
        (failure) => Left(failure),
        (trivia) {
          debugPrint('saved is ${trivia.text}');
          return Right(trivia);
        },
      );
    }
  }
}
