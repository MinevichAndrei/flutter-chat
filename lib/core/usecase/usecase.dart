abstract class UseCase<Type, Params> {
  Stream<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Stream<Type> call();
}

abstract class UseCaseSingle<Type, Params> {
  Type call(Params params);
}

abstract class UseCaseVoid<Type> {
  Type call();
}
