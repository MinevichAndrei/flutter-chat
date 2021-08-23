import 'package:dartz/dartz.dart';
import 'package:flutter_chat/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}
