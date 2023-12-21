abstract class FutureUsecase<Type, Params> {
  Future<Type> call({required Params params});
}
