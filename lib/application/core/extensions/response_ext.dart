import '../../network/result.dart';

extension ApiResponseExt on ApiResponse {
  T fold<T>({
    required T Function() onLoading,
    required T Function(dynamic data) onSuccess,
    required T Function(String message) onError,
  }) {
    if (this is Loading) {
      return onLoading();
    } else if (this is Success) {
      return onSuccess((this as Success).data);
    } else if (this is Error) {
      return onError((this as Error).errorMessage);
    } else {
      throw Exception('Unhandled');
    }
  }
}
