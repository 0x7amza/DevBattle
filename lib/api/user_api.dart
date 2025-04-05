import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  static const String baseUrl = "http://192.168.1.9:3000/api/user";

  static Future<Map<String, dynamic>> signup(String url) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'url': url}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to signup: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> login(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(
    String email,
    String otpCode,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/verify"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otpCode}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to verify OTP: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> logout(String token) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/logout"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to logout: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile?token=$token"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch profile: ${response.body}");
    }
  }
}
