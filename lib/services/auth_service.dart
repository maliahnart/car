import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // late Dio _dio;
  //
  // AuthService() {
  //   final baseUrl = dotenv.env['API_BASE_URL'];
  //   print("🔧 Base URL from env: $baseUrl");
  //   _dio = Dio(BaseOptions(baseUrl: baseUrl ?? ""));
  //   print("ENV loaded: ${dotenv.env}");
  // }
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_BASE_URL']!,
  )
  );

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      print("📡 Sending login request...");

      final response = await _dio.post(
        "auth/login",
        data: {
          "grantType": "password",
          "username": username,
          "password": password,
          "clientId": dotenv.env['CLIENT_ID'],
          "clientSecret": dotenv.env['CLIENT_SECRET'],
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
          contentType: Headers.jsonContentType,
        ),
      );

      print("📩 Response status: ${response.statusCode}");
      print("📩 Response data: ${response.data}");

      return response.data;
    } on DioException catch (e) {
      print("🔥 Login failed!");
      print("Status: ${e.response?.statusCode}");
      print("Data: ${e.response?.data}");
      print("Message: ${e.message}");
      return null;
    } catch (e, s) {
      print("💥 Unexpected error: $e");
      print(s);
      return null;
    }
  }
}
