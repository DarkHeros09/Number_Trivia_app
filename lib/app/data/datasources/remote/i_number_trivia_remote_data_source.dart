import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/number_trivia.dart';
import '../../api/dio_api.dart';

const ERRMSG = 'Unknown Error!!!';

abstract class INumberTriviaRemoteDataSource {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl
    implements INumberTriviaRemoteDataSource {
  final DioApi dioApi;
  const NumberTriviaRemoteDataSourceImpl({@required this.dioApi});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) =>
      _getTriviaFromURL('$number');

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() =>
      _getTriviaFromURL('random');

  Future<Either<Failure, NumberTrivia>> _getTriviaFromURL(String url) async {
    try {
      final response = await dioApi.getTriviaFromUrl(url);
      return Right(response);
    } on DioError catch (error) {
      debugPrint(error.type.toString());
      debugPrint(error.message);
      return const Left(Failure(message: 'Something Went Wrong!!!'));
    } on Exception catch (_) {
      return const Left(Failure(message: ERRMSG));
    }
  }
}
