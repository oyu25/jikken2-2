import 'package:flutter/material.dart';
import 'quiz_page.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新しいページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButtonRow(context, ['あ～お', 'か～こ']),
            SizedBox(height: 10),
            buildButtonRow(context, ['さ～そ', 'た～と']),
            SizedBox(height: 10),
            buildButtonRow(context, ['な～の', 'は～ほ']),
            SizedBox(height: 10),
            buildButtonRow(context, ['ま～も', 'や～よ']),
            SizedBox(height: 10),
            buildButtonRow(context, ['ら～ろ', 'わ～を']),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(BuildContext context, List<String> buttonNames) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (String name in buttonNames)
          CustomButton(onPressed: () => navigateToQuizPage(context), buttonName: name),
      ],
    );
  }

  void navigateToQuizPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage()),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonName;

  const CustomButton({Key? key, this.onPressed, required this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonName),
      ),
    );
  }
}
