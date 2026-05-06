import 'dart:convert';
import 'package:dio/dio.dart';

String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.badResponse) {
    return _handleError(e);
  } else if (e.type == DioExceptionType.connectionTimeout) {
    return "Connection timeout with API server";
  } else if (e.type == DioExceptionType.receiveTimeout) {
    return "Receive timeout in connection with API server";
  } else if (e.type == DioExceptionType.sendTimeout) {
    return "Send timeout in connection with API server";
  } else if (e.type == DioExceptionType.unknown) {
    return "Check your internet connection";
  } else {
    return "Something went wrong";
  }
}

String _handleError(DioException e) {
  final data = e.response?.data;

  if (data is Map) {

    /// ✅ 1. Try frappe _server_messages (BEST)
    if (data['_server_messages'] != null) {
      try {
        final List messages = jsonDecode(data['_server_messages']);
        if (messages.isNotEmpty) {
          final msgObj = jsonDecode(messages.first);
          return msgObj['message'] ?? "Something went wrong";
        }
      } catch (_) {}
    }

    /// ✅ 2. fallback message
    if (data['message'] != null) {
      return data['message'];
    }
  }

  return e.message ?? "Something went wrong";
}