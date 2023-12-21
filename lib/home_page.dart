import 'package:flutter/material.dart';
import 'package:jikken1/secoundpage.dart';
import 'quiz_page.dart'; // Ensure QuizPage is imported

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('クイズ&単語帳'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                );
              },
              child: Text('クイズへ'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
