import 'dart:convert' show json;
import 'package:flutter/services.dart';
import 'question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/Quiz.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      print('Error decoding JSON: $e');
      return [];
    }
  }
}
