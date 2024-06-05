import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../../core/values/constants.dart';
import '../../adapters/dio_error_adapter.dart';
import 'http_service.dart';

class HttpServiceDioImp implements HttpService {
  HttpServiceDioImp();

  Dio _dio({
    bool useBaseUrl = true,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    Map<String, dynamic>? headers,
    String? contentType,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: useBaseUrl ? Constants.baseUrl : '',
      connectTimeout: connectTimeout ?? const Duration(seconds: 10),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 10),
      responseType: responseType,
      headers: headers,
      contentType: contentType,
    ));

    if (kDebugMode) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (dioClient) {
        dioClient.badCertificateCallback = (cert, host, port) => true;
        return dioClient;
      };
    }

    return dio;
  }

  @override
  Future get(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio(
        useBaseUrl: useBaseUrl,
        headers: headers,
      ).get(
        path,
        queryParameters: queryParams,
      );
    } on DioException catch (e) {
      throw DioErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future post(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio(useBaseUrl: useBaseUrl, headers: headers)
          .post(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      throw DioErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future delete(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio(useBaseUrl: useBaseUrl, headers: headers)
          .delete(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      throw DioErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future put(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio(useBaseUrl: useBaseUrl, headers: headers)
          .put(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      throw DioErrorAdapter.convertToErrorModel(e);
    }
  }
}
