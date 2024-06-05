abstract class HttpService {
  Future<dynamic> get(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> post(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> delete(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });

  Future<dynamic> put(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
}
