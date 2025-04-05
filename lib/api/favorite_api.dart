import 'dart:convert';
import 'package:devbattle/utils/token.dart';
import 'package:http/http.dart' as http;

class FavoriteApi {
  final String _baseUrl = "http://192.168.1.9:3000/api";

  Future<Map<String, dynamic>> toggleFavorite({
    required String questionId,
  }) async {
    final url = Uri.parse("$_baseUrl/favorite/$questionId");
    final token = await TokenStorage.getToken();
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to toggle favorite: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error toggling favorite: $e');
    }
  }
}
