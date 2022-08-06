class Params {}

abstract class UseCase<Type, Params> {
  Future<Type> call({Params? params});
}

abstract class UseCaseNoParams<Type> {
  Future<Type> call();
}

class UseCaseException implements Exception {
  final String message;
  UseCaseException(this.message);
}
