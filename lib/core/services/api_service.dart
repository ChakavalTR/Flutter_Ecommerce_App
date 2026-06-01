import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  //! Base URL
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
  //! Dio Instance
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      //! Timeout
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      //! Headers
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      //! Response Type
      responseType: ResponseType.json,
    ),
  );

  //! GET Request
  static Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(endpoint, queryParameters: queryParameters);
  }

  //! POST Request
  static Future<Response> post(String endpoint, {dynamic data}) async {
    return await dio.post(endpoint, data: data);
  }

  //! PUT Request
  static Future<Response> put(String endpoint, {dynamic data}) async {
    return await dio.put(endpoint, data: data);
  }

  //! PATCH Request
  static Future<Response> patch(String endpoint, {dynamic data}) async {
    return await dio.patch(endpoint, data: data);
  }

  //! DELETE Request
  static Future<Response> delete(String endpoint) async {
    return await dio.delete(endpoint);
  }
}
