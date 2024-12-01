class Result<T> {
  final T? data;
  final String? errorMessage;

  bool get isSuccess => errorMessage == null;

  Result.success(this.data) : errorMessage = null;
  Result.failure(this.errorMessage) : data = null;
}
