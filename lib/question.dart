class Question {
  final String text;
  final bool answer;
  final String explanation;

  Question({
    required this.text,
    required this.answer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      answer: json['answer'] as bool,
      explanation: json['explanation'] as String,
    );
  }
}
