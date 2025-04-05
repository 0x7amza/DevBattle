import 'dart:convert';
import 'package:devbattle/utils/token.dart';
import 'package:http/http.dart' as http;

class QuestionApi {
  final String _baseUrl = "http://192.168.1.9:3000/api/question";

  Future<List> fetchQuestions({String? search}) async {
    try {
      var token = await TokenStorage.getToken();
      final uri = Uri.parse("$_baseUrl").replace(
        queryParameters: {'token': token, if (search != null) 'search': search},
      );

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return List<dynamic>.from(json.decode(response.body));
      } else {
        throw Exception(
          'Failed to load questions. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }

  Future<Map<String, dynamic>> fetchQuestionById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/$id"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Question not found');
      } else {
        throw Exception(
          'Failed to load question. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching question: $e');
    }
  }

  Future<Map<String, dynamic>> runCode({
    required String id,
    required String code,
    required int languageId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/$id/run"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'code': code, 'languageId': languageId}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Question not found');
      } else if (response.statusCode == 500) {
        throw Exception('Error running the code');
      } else {
        throw Exception(
          'Failed to run code. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error running code: $e');
    }
  }

  Future<List<dynamic>> fetchSubmissionsByQuestionId(String questionId) async {
    try {
      var token = await TokenStorage.getToken();
      final uri = Uri.parse(
        "$_baseUrl/submissions/$questionId",
      ).replace(queryParameters: {'token': token});

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return List<dynamic>.from(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Submissions not found');
      } else {
        throw Exception(
          'Failed to load submissions. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching submissions: $e');
    }
  }
}
