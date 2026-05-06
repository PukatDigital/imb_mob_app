abstract class Result<T> {
  onSuccess(T result);

  onError(String error);
}

abstract class ErrorResult {
  onError(String error);
}
