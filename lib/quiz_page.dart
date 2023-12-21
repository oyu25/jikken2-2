import 'package:flutter/material.dart';
import 'question.dart';
import 'api_service.dart';
import 'result_screen.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final loadedQuestions = await ApiService.fetchQuestions();
      setState(() {
        questions = loadedQuestions.toList()..shuffle();
      });
    } catch (e) {
      print('Error loading questions: $e');
    }
  }

  void checkAnswer(bool userAnswer) {
    String explanation = questions[currentQuestionIndex].explanation;
    bool isCorrect = userAnswer == questions[currentQuestionIndex].answer;

    String userSymbol = userAnswer ? '〇' : '☓';
    String correctAnswerSymbol = questions[currentQuestionIndex].answer ? '〇' : '☓';

    // 新しい選択肢情報
    bool? userChoice = userAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('あなたの回答: $userSymbol'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isCorrect
                  ? Text('正解！')
                  : Text('不正解.. 正解は「$correctAnswerSymbol」です。'),
              Text(explanation),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Move to the next question or show the result
                  setState(() {
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                    } else {
                      // Quiz is finished, show the score
                      showResultDialog(userChoice);
                    }
                  });
                },
                child: Text(currentQuestionIndex < questions.length - 1 ? '次へ' : '結果を見る'),
              ),
            ],
          ),
        );
      },
    );

    if (isCorrect) {
      setState(() {
        correctAnswers++;
      });
    }
  }

  void showResultDialog(bool? userChoice) {
    // ResultScreen に遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: questions,
          userAnswers: List.generate(questions.length, (index) {
            return index < correctAnswers;
          }),
          userChoices: List.generate(questions.length, (index) {
            return index == currentQuestionIndex ? userChoice : null;
          }),
          retryQuiz: () {
            // もう一回ボタンが押されたときの処理
            Navigator.of(context).pop(); // 結果画面を閉じる
            // クイズをリセット
            setState(() {
              currentQuestionIndex = 0;
              correctAnswers = 0;
            });
            _loadQuestions(); // 新しいクイズを読み込む
          },
          goToHome: () {
            // ホームに戻るボタンが押されたときの処理
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('方言〇☓ゲーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '第${currentQuestionIndex + 1}問',
            ),
            Text(
              '${questions.isNotEmpty ? questions[currentQuestionIndex].text : "Loading..."}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (questions.isNotEmpty) {
                      checkAnswer(true);
                    }
                  },
                  child: Text('〇'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questions.isNotEmpty) {
                      checkAnswer(false);
                    }
                  },
                  child: Text('☓'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}