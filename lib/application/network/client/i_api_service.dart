// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import '../external-values/i_external_values.dart';
//
// abstract class IApiService {
//   Dio get();
//
//   void serviceGenerator(IExternalValues externalValues);
//
//   BaseOptions getBaseOptions(IExternalValues externalValues);
//
//   HttpClient httpClientCreate();
//
//   void setIsTokenRequired({bool value});
//
//   void enableLogger(bool value);
// }
import 'dart:io';

import 'package:dio/dio.dart';

import '../external-values/i_external_values.dart';

abstract class IApiService {
  Dio get();

  void serviceGenerator(IExternalValues externalValues);

  BaseOptions getBaseOptions(IExternalValues externalValues);

  HttpClient httpClientCreate();

  void setIsTokenRequired({bool value});

  void enableLogger(bool value);

  /// ✅ Chat base URL + path ko mila kar poora absolute URL return karta hai.
  /// Isko dio.get(url) / dio.post(url) mein directly path ki jagah pass karo.
  String chatUrl(String path);
}