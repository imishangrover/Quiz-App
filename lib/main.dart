import 'package:flutter/material.dart';
import 'package:quizzer/Quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          )
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void ansCheck(bool userPickedAns){
    bool CorrectAns = quiz.getCorrectAns();
    setState(() {
      if(quiz.isFinished() == true){
        Alert(
          context: context,
          title: 'Finished',
          desc: "You've reached at the end of quiz"
        ).show();
        quiz.finished();
        ScoreKeeper = [];
      }
      
      else{
        if(userPickedAns == CorrectAns){
          ScoreKeeper.add(const Icon(Icons.check,color: Colors.green,));
        }
        else{
          ScoreKeeper.add(const Icon(Icons.close,color: Colors.red,));
        }
        quiz.nextQuestion();
      }
    });
  }
  List <Icon> ScoreKeeper = [];
  Quiz quiz = Quiz();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Expanded(
          flex: 5,
          child: 
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                quiz.getQuestionText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ),
          ),
        Expanded(
          child: TextButton(
            onPressed: () {
              ansCheck(true);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              height: 90,
              width: 400,
              child: 
              const Text(
                'True',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              ansCheck(false);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              height: 90,
              width: 400,
              child: 
              const Text(
                'False',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              ),
            ),
          ),
        ),
      
      Row(
        children: ScoreKeeper,
      )
      ],
    );
  }
}


