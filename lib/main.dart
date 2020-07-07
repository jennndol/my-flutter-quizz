import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuiiz',
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MyQuiz(),
          ),
        ),
      ),
    );
  }
}

class MyQuiz extends StatefulWidget {
  @override
  _MyQuizState createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  List<String> questions = [
    'Everest adallah gunung tertinggi di dunia.',
    'Tom adalah nama kucing dalam film Tom and Jerry.',
    'Slum Dog Millionaire dibintangi oleh Shah Rukh Khan.'
  ];
  List<bool> answers = [true, true, false];
  int index = 0;
  int rightCount = 0;

  void restartApp() {
    setState(() {
      index = 0;
      rightCount = 0;
    });
  }

  void showAlert() {
    SweetAlert.show(context,
        title: "You got $rightCount right from ${questions.length} questions",
        subtitle: "Thank you for playing this quiz app",
        style: SweetAlertStyle.success);
  }

  void checkAnswer(bool clickedAnswer) {
    bool correctAnswer = answers[index];
    if (clickedAnswer == correctAnswer) {
      rightCount++;
    }
  }

  void nextQuestion() {
    setState(() {
      if (index < questions.length - 1) {
        index++;
      } else {
        showAlert();
        restartApp();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Benar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                nextQuestion();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'Salah',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                  nextQuestion();
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
