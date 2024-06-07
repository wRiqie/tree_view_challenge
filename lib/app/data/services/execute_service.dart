import '../models/default_response_model.dart';
import '../models/error_model.dart';

class ExecuteService {
  ExecuteService._();

  /// Used to convert Response in defaultReponseModel [Success or error]
  static Future<DefaultResponseModel<T>> tryExecuteAsync<T>(
      Future<T?> Function() execute) async {
    try {
      final response = await execute();
      return DefaultResponseModel<T>(data: response);
    } on ErrorModel catch (e) {
      return DefaultResponseModel<T>(error: e);
    }
  }
}
