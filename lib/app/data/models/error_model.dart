import 'package:dio/dio.dart';

import '../../core/values/constants.dart';

class ErrorModel implements Exception {
  final String message;

  ErrorModel(this.message);

  factory ErrorModel.fromApi(DioException exception) {
    try {
      var data = exception.response?.data;

      return ErrorModel(data['title']);
    } catch (e) {
      return ErrorModel(Constants.defaultError);
    }
  }
}
