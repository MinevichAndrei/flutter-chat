abstract class UseCase<Type, Params> {
  Stream<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Stream<Type> call();
}
