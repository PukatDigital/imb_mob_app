sealed class ApiResponse {}

class None extends ApiResponse {}

class Loading extends ApiResponse {
  final int? index;

  Loading({this.index});
}

class Success<T> extends ApiResponse {
  final T data;

  Success(this.data);

  bool get isEmpty {
    if (data == null) {
      return true;
    } else if (data is List<T>) {
      return (data as List<T>).isEmpty;
    } else if (data is Set) {
      return (data as Set).isEmpty;
    } else if (data is Map) {
      return (data as Map).isEmpty;
    } else if (data is String) {
      return (data as String).isEmpty;
    }
    return false;
  }
}

class Error extends ApiResponse {
  final String errorMessage;

  Error(this.errorMessage);
}
