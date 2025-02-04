import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? dio}) : dio = dio ?? Dio();

  Future<dynamic> getRequest(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw Exception('API GET request failed: ${e.message}');
    }
  }

  Future<dynamic> postRequest(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.post(url, data: data, queryParameters: queryParameters);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('API POST request failed: ${e.message}');
    }
  }
}
