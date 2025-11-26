abstract class UseCase<T, Params> { // T represent Type
  Future<T> call({Params params});
}