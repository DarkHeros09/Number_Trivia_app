import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Failure extends Equatable {
  final String message;
  const Failure({@required this.message});
  @override
  String toString() => message;
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({@required final String message})
      : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({@required final String message})
      : super(message: message);
}
