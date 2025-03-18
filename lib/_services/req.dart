import 'package:dio/dio.dart';
import 'package:repair/_services/storage.dart';

import '../Utils/app_exceptions.dart';

class Req {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Attach Authorization Header
  Future<void> _attachAuthHeader() async {
    final token = await Storage.getToken();
    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      // No token, allow the request to proceed without Authorization
      _dio.options.headers.remove('Authorization');
    }
  }

  // JSON POST Request
  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // Multipart FormData POST Request
  Future<dynamic> postMultipart(String url, FormData data) async {
    await _attachAuthHeader();
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // GET Request
  Future<dynamic> get(String url) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // PUT Request
  Future<dynamic> put(String url, Map<String, dynamic> data) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // DELETE Request
  Future<dynamic> delete(String url) async {
    await _attachAuthHeader();
    try {
      final response = await _dio.delete(url);
      return response.data;
    } on DioException catch (error) {
      throw _handleError(error);
    }
  }

  // Error Handling
  AppException _handleError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          return BadRequestException(
              "Bad Request", error.response?.data["message"].toString());
        case 401:
          return UnauthorizedException(
              "Unauthorized", error.response?.data["message"].toString());
        case 404:
          return NotFoundException(
              "Not Found", error.response?.data["message"].toString());
        case 500:
          return InternalServerError("Internal Server Error",
              error.response?.data["message"].toString());
        default:
          return AppException(
              "Unexpected Error", error.response?.data["message"].toString());
      }
    } else {
      return AppException("Unexpected Error", error.message);
    }
  }
}
