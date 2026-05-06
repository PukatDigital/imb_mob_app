import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../di/di.dart';
import '../../common/log.dart';
import '../external-values/i_external_values.dart';
import 'i_api_service.dart';

class ApiService extends Interceptor implements IApiService {
  ApiService.create({required IExternalValues externalValues}) {
    serviceGenerator(externalValues);
  }

  bool _isTokenRequired = false;

  @override
  Dio get() => _dio;

  @override
  BaseOptions getBaseOptions(IExternalValues externalValues) {
    return BaseOptions(
        baseUrl: externalValues.getBaseUrl(),
        receiveDataWhenStatusError: true,
        // headers: {Headers.contentTypeHeader: "application/x-www-form-urlencoded"},
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30));
  }

  @override
  HttpClient httpClientCreate() {
    final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
    // You can test the intermediate / root cert here. We just ignore it.
    client.badCertificateCallback = (cert, host, port) => true;

    return client;
  }

  @override
  void serviceGenerator(IExternalValues externalValues) {
    _dio = Dio(getBaseOptions(externalValues));
    _dio.interceptors.add(this);

    _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: httpClientCreate);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    d(options.path);
    d(options.toString());

    if (_isTokenRequired) {
      final prefHelper = inject<IPrefHelper>();

      // ✅ Frappe uses "token api_key:api_secret" format
      final loginModel = prefHelper.loginModel;
      final apiKey = loginModel?.data?.user?.apiKey;
      final apiSecret = loginModel?.data?.user?.apiSecret;

      if (apiKey != null && apiSecret != null) {
        d("Using Frappe token: $apiKey:$apiSecret");
        options.headers.addAll({
          "Authorization": "token $apiKey:$apiSecret",
        });
      } else {
        // fallback: session_id as Bearer (won't work for Frappe API)
        final token = prefHelper.retrieveToken();
        if (token != null) {
          d("Fallback token: $token");
          options.headers.addAll({
            "Authorization": "Bearer $token",
          });
        }
      }
    }

    options.headers.addAll({
      Headers.contentTypeHeader: "application/json",
      Headers.acceptHeader: "application/json",
    });

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  late Dio _dio;

  @override
  void setIsTokenRequired({bool value = true}) {
    _isTokenRequired = value;
  }

  @override
  void enableLogger(bool value) {
    if (value) {
      _dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, compact: false));
    }
  }
}
