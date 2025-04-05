import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaderboardApi {
  final String _baseUrl = "http://192.168.1.9:3000/api";

  Future<List<User>> fetchLeaderboard({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/Leaderboard?limit=$limit"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        List<User> users =
            jsonResponse.map((userJson) => User.fromJson(userJson)).toList();

        return users;
      } else {
        throw Exception(
          'Failed to load leaderboard. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching leaderboard: $e');
    }
  }
}

class User {
  final String name;
  final String profilePicture;
  final int score;

  User({required this.name, required this.profilePicture, required this.score});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'Unknown',
      profilePicture: json['profilePicture'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
